class_name Equipment_Slot_Node extends Inventory_Slot_Node

# Does as the parent func and set the placeholder.
func set_slot( value ):
	super.set_slot( value )
	
	if slot and not slot.item:
		%placeholder.texture = ResourceManager.get_placeholder( slot.type )

# When the item change, update the placeholder.
func _on_item_changed():
	super._on_item_changed()
	%placeholder.visible = slot.item == null
