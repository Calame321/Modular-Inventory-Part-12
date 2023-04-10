class_name Equipment_Slot_Node extends Inventory_Slot_Node

export( NodePath ) onready var placeholder = get_node( placeholder ) as TextureRect

# Does as the parent func and set the placeholder.
func set_slot( value ):
	.set_slot( value )
	
	if slot and not slot.item:
		placeholder.texture = ResourceManager.get_placeholder( slot.type )

# When the item change, update the placeholder.
func _on_item_changed():
	._on_item_changed()
	placeholder.visible = slot.item == null
