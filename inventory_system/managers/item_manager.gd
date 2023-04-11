extends Node

const ITEM_PATH = "res://inventory_system/data/json/items.json"
const AFFIXES_PATH = "res://inventory_system/data/json/affixes.json"
const RARE_NAMES_PATH = "res://inventory_system/data/json/rare_names.json"

var items = {}
var rare_names = {}
var affix_groups = {}

var equipment_names = {
	Game_Enums.EQUIPMENT_TYPE.HEAD: "Head",
	Game_Enums.EQUIPMENT_TYPE.CHEST: "Armor",
	Game_Enums.EQUIPMENT_TYPE.OFFHAND: "Offhand",
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND: "Weapon"
}


var type_names = {
	Game_Enums.ITEM_TYPE.CONSUMABLE: "Consumable",
	Game_Enums.ITEM_TYPE.CURRENCY: "Currency",
	Game_Enums.ITEM_TYPE.MATERIAL: "Material",
}


var usable = {
	"healing": preload( "res://inventory_system/scripts/resources/usable_items/item_healing.gd" ),
	"upgrade": preload( "res://inventory_system/scripts/resources/usable_items/item_upgrade.gd" ),
}

# Get a random seed for the random functions.
func _init():
	randomize()

# Load the content of the data files.
func _ready():
	var file = File.new()
	
	# items
	file.open( ITEM_PATH, File.READ )
	var test_json_conv = JSON.new()
	test_json_conv.parse( file.get_as_text() )
	items = test_json_conv.get_data()
	file.close()
	
	# names
	file.open( RARE_NAMES_PATH, File.READ )
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	rare_names = test_json_conv.get_data()
	file.close()
	
	# affixes group
	file.open( AFFIXES_PATH, File.READ )
	var test_json_conv = JSON.new()
	test_json_conv.parse( file.get_as_text() )
	var data = test_json_conv.get_data()
	for id in data:
		affix_groups[ id ] = Affix_Group.new( id, data[ id ] )
	file.close()

# Build the item of the given id.
func get_item( id : String ) -> Item:
	var data = items[ id ]
	var item = Item.new()
	item.id = id
	item.name = data.name
	item.level = data.level
	item.type = Game_Enums.ITEM_TYPE[ data.type ]
	
	if item.type == Game_Enums.ITEM_TYPE.EQUIPMENT: item.equipment_type = Game_Enums.EQUIPMENT_TYPE[ data.equipment_type ]
	if data.has( "rarity" ): item.rarity = Game_Enums.RARITY[ data.rarity ]
	if data.has( "stack_size" ): item.stack_size = data.stack_size
	if data.has( "base_stats" ): item.components[ "base_stats" ] = Base_stat.new( data.base_stats )
	if data.has( "unique" ): item.unique_data = data[ "unique" ]
	if data.has( "usable" ): item.components[ "usable" ] = ItemManager.get_usable( data.usable, item )
	return item

# Build multiple items at once with the array of ids.
func get_items( items_data : Array ) -> Array:
	var items_array = []
	for item_data in items_data:
		items_array.append( get_item_from_data( item_data ) )
	return items_array

# Build an item from a dictionary. ( usually from item.get_data() )
func get_item_from_data( item_data ):
	var item = get_item( item_data.id )
	item.quantity = item_data.quantity
	if item_data.has( "item_name" ): item.name = item_data.item_name 
	if item_data.has( "rarity" ): item.rarity = item_data.rarity
	if item_data.has( "components" ):
		if item_data.components.has( "base_stats" ): item.components.base_stats.scale = item_data.components.base_stats
		if item_data.components.has( "affix_list" ): item.components.affix_list = Item_Affix_List.new( item_data.components.affix_list, item.rarity )
		if item_data.components.has( "unique_stats" ): set_unique( item, item_data.components.unique_stats )
	return item

# Get random equipable item
func rng_generate_rarity( ilvl ) -> Item:
	var valid_items_key = []
	for i in items:
		if items[ i ].has( "type" ) and ilvl >= items[ i ].level and Game_Enums.ITEM_TYPE[ items[ i ].type ] == Game_Enums.ITEM_TYPE.EQUIPMENT:
			valid_items_key.append( i )
	var item = get_item( valid_items_key[ randi() % valid_items_key.size() ] )
	return generate_random_rarity( item, ilvl )

# Randomly select a rarity for the item.
func generate_random_rarity( item, ilvl ):
	item.components.base_stats.scale = randf()
	
	# Get random rarity
	var rarity = Game_Enums.RARITY.NORMAL
	var rng = randf()
	if rng >= 0 and item.unique_data: # 1%
		rarity = Game_Enums.RARITY.UNIQUE
	elif rng >= 0.9: # 9%
		rarity = Game_Enums.RARITY.RARE
	elif rng >= 0.6: # 30%
		rarity = Game_Enums.RARITY.MAGIC
	
	generate_rarity( item, ilvl, rarity )
	return item

# Randomly selects affixes / stats for the item based on it's rarity.
func generate_rarity( item, ilvl, rarity ) -> Item:
	item.rarity = rarity
	var number_of_affixes = 0
	
	if rarity == Game_Enums.RARITY.UNIQUE:
		item.rarity = Game_Enums.RARITY.UNIQUE
		roll_unique( item )
		return item
	elif rarity == Game_Enums.RARITY.RARE:
		item.rarity = Game_Enums.RARITY.RARE
		number_of_affixes = ( randi() % 3 ) + 3
		set_rare_name( item )
	elif rarity == Game_Enums.RARITY.MAGIC:
		item.rarity = Game_Enums.RARITY.MAGIC
		number_of_affixes = ( randi() % 2 ) + 1
	else:
		return item
	
	# Set the affixes
	var random_affix_group = get_random_affix_group( number_of_affixes, item.equipment_type, ilvl )
	var item_affix_list_data = []
	
	for affix_group in random_affix_group:
		var data = {
			"affix_group": affix_group.id,
			"affix": affix_group.get_random_affix( ilvl ),
			"scale": randf()
		}
		item_affix_list_data.append( data )
	
	item.components[ "affix_list" ] = Item_Affix_List.new( item_affix_list_data, item.rarity )
	return item

# Randomly selects affixes for the item based on its rarity and level.
func get_random_affix_group( affix_amount, item_type, ilvl ) -> Array:
	var valid_prefixes : Array = get_valid_affixes_group( Game_Enums.AFFIX_TYPE.PREFIX, item_type, ilvl )
	var valid_suffixes : Array = get_valid_affixes_group( Game_Enums.AFFIX_TYPE.SUFFIX, item_type, ilvl )
	
	valid_prefixes.shuffle()
	valid_suffixes.shuffle()
	
	var prefix_amount = int( floor( affix_amount / 2.0 ) )
	var suffix_amount = prefix_amount
	
	if affix_amount % 2 == 1:
		if randi() % 2 == 1:
			prefix_amount += 1
		else:
			suffix_amount += 1
	
	valid_prefixes.resize( prefix_amount )
	valid_suffixes.resize( suffix_amount )
	
	var valid_affixes = []
	valid_affixes.append_array( valid_prefixes )
	valid_affixes.append_array( valid_suffixes )
	return valid_affixes

# Get the possible affixes on the item based on the level and it's equipment type.
func get_valid_affixes_group( affix_type, item_type, ilvl ):
	var valid_affixes : Array = []
	
	for id in affix_groups:
		if affix_groups[ id ].type == affix_type and ilvl >= affix_groups[ id ].affixes.values()[ 0 ].min_level and affix_groups[ id ].apply_to.has( item_type ):
			valid_affixes.append( affix_groups[ id ] )
	return valid_affixes

# Sets a random name for rare items.
func set_rare_name( item ):
	var type = Game_Enums.EQUIPMENT_TYPE.keys()[ item.equipment_type ]
	var name_prefix_type = rare_names.prefix[ type ]
	var name_prefix = name_prefix_type[ randi() % name_prefix_type.size() ]
	var name_suffix_type = rare_names.suffix[ type ]
	var name_suffix = name_suffix_type[ randi() % name_suffix_type.size() ]
	item.name = name_prefix + " " + name_suffix

# Roll the weight for the unique stats.
func roll_unique( item ):
	var scales = []
	for s in item.unique_data.stats:
		scales.append( randf() )
	set_unique( item, scales )

# Sets the unique data on the item.
func set_unique( item, scales ):
	item.name = item.unique_data.name
	item.components[ "unique_stats" ] = Item_Unique_Stats.new( item.unique_data.stats, scales )
	if item.unique_data.has( "usable" ):
		set_usable( item, item.unique_data )

# Get the usable script for the item and sets it's data.
func get_usable( data_usable, item ):
	return usable[ data_usable.type ].new( data_usable.data, item )

# Set the usable script on an existing item with the given data.
func set_usable( item, data ):
	item.components[ "usable" ] = get_usable( data.usable, item )

# Get the name of an item type to display.
func get_type_name( item ):
	if item.type == Game_Enums.ITEM_TYPE.EQUIPMENT:
		return equipment_names[ item.equipment_type ]
	else:
		return type_names[ item.type ]



