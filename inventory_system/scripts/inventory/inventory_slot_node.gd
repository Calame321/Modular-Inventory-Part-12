class_name Inventory_Slot_Node extends TextureRect

var slot : set = set_slot

# When the slot resource is set, draw it and connect the signals.
func set_slot( value ):
	slot = value
	
	if slot and slot.item:
		var item_node = ResourceManager.get_item_node( slot.item )
		%item_container.add_child( item_node )
	
	if not is_connected("mouse_entered", Callable(InventoryManager, "_on_mouse_entered_slot")):
		connect("mouse_entered", Callable(InventoryManager, "_on_mouse_entered_slot").bind(self))
		connect("mouse_exited", Callable(InventoryManager, "_on_mouse_exited_slot"))
		connect("gui_input", Callable(InventoryManager, "_on_gui_input_slot").bind(self))
		slot.connect("item_changed", Callable(self, "_on_item_changed"))

# When the slot is shown or hidden, cause a mouse exited signal so the item info hides.
func _on_item_container_visibility_changed():
	emit_signal( "mouse_exited" )

# When the item change, update the visual.
func _on_item_changed():
	for c in %item_container.get_children():
		c.queue_free()
	
	if slot.item:
		%item_container.add_child( ResourceManager.get_item_node( slot.item ) )
