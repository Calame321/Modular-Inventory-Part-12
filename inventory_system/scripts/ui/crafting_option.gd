extends InnerPanel

export ( NodePath ) onready var price_list = get_node( price_list ) as VBoxContainer
export ( NodePath ) onready var produce_list = get_node( produce_list ) as VBoxContainer
export ( NodePath ) onready var craft_btn = get_node( craft_btn ) as Button

var price: Array
var produce: Array

func _ready():
	SignalManager.connect( "inventory_group_content_changed", self, "_on_inventory_group_changed" )

# Set the price and produce list.
func set_info( recipe_id, price_items, produce_items ):
	price = price_items
	produce = produce_items
	set_title( recipe_id )
	set_craft_button()
	
	for item_data in price_items:
		var price_node = ResourceManager.get_instance( "item_quantity" )
		price_list.add_child( price_node )
		var item = ItemManager.get_item( item_data.id )
		price_node.set_info( item, item_data.quantity )
	
	for item_data in produce_items:
		var produce_node = ResourceManager.get_instance( "item_quantity" )
		produce_list.add_child( produce_node )
		var item = ItemManager.get_item( item_data.id )
		produce_node.set_info( item, item_data.quantity )

# Activate the craft button if the 'crafting' inventories has the needed items
# and the 'player' inventories has enough space for the produced items.
func set_craft_button():
	var can_craft = InventoryManager.has_items( price, "crafting" ) and InventoryManager.has_space_for_items( produce, "player" )
	craft_btn.disabled = not can_craft

# When crafting, remove the price tiems, adds the produces.
func _on_craft_pressed():
	InventoryManager.remove_items( ItemManager.get_items( price ), "crafting" )
	InventoryManager.add_items( ItemManager.get_items( produce ), "player" )

# Check to see if it's possible to craft after a change in the player/crafting inventories.
func _on_inventory_group_changed( groups ):
	if groups.has( "player" ) or groups.has( "crafting" ):
		set_craft_button()




