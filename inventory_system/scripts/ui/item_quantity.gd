extends ColorRect

# Set the needed item and quantity for crafting.
func set_info( item : Item, quantity : int ):
	%item_container.add_child( ResourceManager.get_item_node( item ) )
	%quantity.text = str( quantity )
