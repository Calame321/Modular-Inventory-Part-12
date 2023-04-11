class_name Item_Upgrade extends Item_Usable

func _init( data, parent_item ):
	super( data, parent_item )
	on_use_text = "Uprade an item to mag or rare."
	condition = "Have an item that is normal or magic in your inventory."

# Show the effect.
func get_use_text():
	return on_use_text

# Send the signal to upgrade an item in the player's inventories.
func execute():
	SignalManager.emit_signal( "upgrade_item" )

# Check if the item is still usable after a change in the player's inventories.
func _on_inventory_group_content_changed( groups ):
	if groups.has( "player" ):
		can_use = InventoryManager.has_upgradable_items( "player" )
		emit_signal( "can_use_changed", is_usable() )
