class_name Item_Info extends Scale_Control

export( NodePath ) onready var item_name = get_node( item_name ) as Label
export( NodePath ) onready var line_container = get_node( line_container ) as Control

# Display the hovered item info.
# Each components on the item also adds their info.
func display( slot_node : Inventory_Slot_Node ):
	for c in line_container.get_children():
		line_container.remove_child( c )
		c.queue_free()
	
	var slot = slot_node.slot
	item_name.text = slot.item.get_name()
	var rarity_name = Game_Enums.RARITY.keys()[ slot.item.rarity ].capitalize()
	var line_type = Item_Info_Line.new( rarity_name + "   " + ItemManager.get_type_name( slot.item ), slot.item.rarity )
	line_container.add_child( line_type )
	
	for c in slot.item.components.values():
		c.set_info( self )
	
	rect_size = Vector2.ZERO
	show()
	
	rect_global_position = ( slot_node.rect_size * SettingsManager.scale ) + slot_node.rect_global_position
	var window_size = get_viewport().get_visible_rect().size
	var scaled = ( rect_size * scale )
	
	if rect_global_position.y + scaled.y > window_size.y:
		rect_global_position.y = window_size.y - scaled.y
	
	if rect_global_position.x + scaled.x > window_size.x:
		rect_global_position.x = slot_node.rect_global_position.x - scaled.x

# Add a line node in the list.
func add_line( line ):
	line_container.add_child( line )

# Add a spliter line in the list.
func add_splitter():
	add_line( ResourceManager.tscn.splitter.instance() )




