class_name Hotbar_Slot extends Inventory_Slot

var key : String

func _init( i, inv_name ).( i, inv_name ):
	key = str( i + 1 )
	can_drop = false
	can_split = false

# Dosen't look if the item is stackable.
func try_put_item( new_item : Item ) -> bool:
	return accept_item( new_item ) and .try_put_item( new_item )

# Disconnect the depleted signal on the old item.
func unset_old_item():
	if item:
		item.disconnect( "depleted", self, "_on_item_depleted" )

# Connect the depleted signal on the new item.
func set_new_item():
	if item:
		item.connect( "depleted", self, "_on_item_depleted" )

# Always return the item we want to place in the slot.
func put_item( new_item : Item ) -> Item:
	.put_item( new_item )
	return new_item

# Cannot stack item in this type of slot.
func can_stack( _new_item ):
	return false
