class_name Resource_Manager extends Node

const STAT_PATH = "res://inventory_system/data/json/stats.json"
const RECIPE_PATH = "res://inventory_system/data/json/recipes.json"

var sprites = {
	"chestplate": preload( "res://inventory_system/resources/sprites/items/chestplate.png" ),
	"crystal": preload( "res://inventory_system/resources/sprites/items/crystal.png" ),
	"gold_coin": preload( "res://inventory_system/resources/sprites/items/gold_coin.png" ),
	"helmet": preload( "res://inventory_system/resources/sprites/items/helmet.png" ),
	"iron_sword": preload( "res://inventory_system/resources/sprites/items/iron_sword.png" ),
	"magic_orb": preload( "res://inventory_system/resources/sprites/items/magic_orb.png" ),
	"shield": preload( "res://inventory_system/resources/sprites/items/shield.png" ),
	"stone_brick": preload( "res://inventory_system/resources/sprites/items/stone_brick.png" ),
	"tshirt": preload( "res://inventory_system/resources/sprites/items/tshirt.png" ),
	"wood": preload( "res://inventory_system/resources/sprites/items/wood.png" ),
	"wooden_sword": preload( "res://inventory_system/resources/sprites/items/wooden_sword.png" ),
	"small_healing_potion": preload( "res://inventory_system/resources/sprites/items/small_red_potion.png" ),
	"big_healing_potion": preload( "res://inventory_system/resources/sprites/items/big_red_potion.png" ),
	"rarity_upgrade": preload( "res://inventory_system/resources/sprites/items/rarity_upgrade.png" ),
	"plank": preload( "res://inventory_system/resources/sprites/items/plank.png" ),
	"rock": preload( "res://inventory_system/resources/sprites/items/rock.png" ),
}

var fonts = {
	8: preload( "res://inventory_system/resources/font/font_8.tres" )
}

var colors = {
	Game_Enums.RARITY.NORMAL : Color( "905c32" ),
	Game_Enums.RARITY.MAGIC : Color( "5b6ee1" ),
	Game_Enums.RARITY.RARE : Color( "999200" ),
	Game_Enums.RARITY.UNIQUE : Color( "bf3d00" ),
}

var tscn = {
	"splitter": preload( "res://inventory_system/scenes/ui/splitter.tscn" ),
	"hotbar_slot_node": preload( "res://inventory_system/scenes/inventory/hotbar_slot_node.tscn" ),
	"floor_item": preload( "res://inventory_system/scenes/interactables/floor_item.tscn" ),
	"cooldown": preload( "res://inventory_system/scenes/ui/cooldown.tscn" ),
	"crafting_option": preload( "res://inventory_system/scenes/ui/crafting_option.tscn" ),
	"item_quantity": preload( "res://inventory_system/scenes/ui/item_quantity.tscn" ),
	"inventory_slot_node": preload( "res://inventory_system/scenes/inventory/inventory_slot_node.tscn" ),
	"inventory_node": preload( "res://inventory_system/scenes/inventory/inventory_node.tscn" ),
	"item_node": preload( "res://inventory_system/scenes/inventory/item_node.tscn" ),
	"equipment_node": preload( "res://inventory_system/scenes/inventory/equipment_node.tscn" )
}

onready var placeholders = {
	Game_Enums.EQUIPMENT_TYPE.HEAD : preload( "res://inventory_system/resources/sprites/placeholder_head.png" ),
	Game_Enums.EQUIPMENT_TYPE.CHEST : preload( "res://inventory_system/resources/sprites/placeholder_chest.png" ),
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND : preload( "res://inventory_system/resources/sprites/placeholder_main_hand.png" ),
	Game_Enums.EQUIPMENT_TYPE.OFFHAND : preload( "res://inventory_system/resources/sprites/placeholder_offhand.png" ),
}

var stat_info = {}
var recipes_info = {}

func _ready():
	# Load the stats
	var file = File.new()
	file.open( STAT_PATH, File.READ )
	var data = parse_json( file.get_as_text() )
	for stat in data:
		stat_info[ Game_Enums.STAT[ stat ] ] = data[ stat ]
	file.close()
	
	# Load the recipes
	file.open( RECIPE_PATH, File.READ )
	recipes_info = parse_json( file.get_as_text() )
	file.close()

# Get a prefab scene instance from it's id.
func get_instance( id ):
	return tscn[ id ].instance()

# Get the recipe from it's id.
func get_recipes( id ):
	return recipes_info[ id ]

# Get the placeholder sprite for the equipment slot.
func get_placeholder( id ):
	return placeholders[ id ]

# Get the item node to be displayed in a slot.
func get_item_node( item ):
	var item_node = tscn.item_node.instance()
	item_node.item = item
	item_node.texture = sprites[ item.id ]
	return item_node
















