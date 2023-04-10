extends ColorRect

export ( NodePath ) onready var item_container = get_node( item_container ) as Control
export ( NodePath ) onready var lbl_quantity = get_node( lbl_quantity ) as Label

# Set the needed item and quantity for crafting.
func set_info( item : Item, quantity : int ):
	item_container.add_child( ResourceManager.get_item_node( item ) )
	lbl_quantity.text = str( quantity )
