class_name Inventory_Slot_Node extends TextureRect

var slot : set = set_slot

# When the slot resource is set, draw it and connect the signals.
func set_slot( value ):
	slot = value
	
	if slot and slot.item:
		var item_node = ResourceManager.get_item_node( slot.item )
		%item_container.add_child( item_node )
	
	if not mouse_entered.is_connected( InventoryManager._on_mouse_entered_slot ):
		mouse_entered.connect( InventoryManager._on_mouse_entered_slot.bind( self ) )
		mouse_exited.connect( InventoryManager._on_mouse_exited_slot )
		gui_input.connect( InventoryManager._on_gui_input_slot.bind( self ) )
		slot.item_changed.connect( _on_item_changed )

# When the slot is shown or hidden, cause a mouse exited signal so the item info hides.
func _on_item_container_visibility_changed():
	mouse_exited.emit()

# When the item change, update the visual.
func _on_item_changed():
	for c in %item_container.get_children():
		c.queue_free()
	
	if slot.item:
		%item_container.add_child( ResourceManager.get_item_node( slot.item ) )
