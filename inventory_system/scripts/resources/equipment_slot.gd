class_name Equipment_Slot extends Inventory_Slot

@export ( Game_Enums.EQUIPMENT_TYPE ) var type

# Set the type of equipment accepted.
func _init( i, inv_name, t ):
	super( i, inv_name )
	type = t

# The type of the item must be the same as the slot.
func accept_item( new_item ) -> bool:
	return new_item.equipment_type == type and super.accept_item( new_item )

# same as parent.
func try_put_item( new_item : Item ) -> bool:
	return accept_item( new_item ) and super.try_put_item( new_item )

# if it's not the correct type, return the new item.
func put_item( new_item : Item ) -> Item:
	if new_item:
		if new_item.equipment_type != type:
			return new_item
	return super.put_item( new_item )

# Get the total of the given stat from the item.
func get_stat( stat ):
	return item.get_stat( stat ) if item else 0
