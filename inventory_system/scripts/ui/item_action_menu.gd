extends Scale_Control

var actions = []
var actions_args = []

func _ready():
	super()
	%item_menu.hide()

# Display the menu for the selected item.
func display( slot_node ):
	%item_menu.position = slot_node.global_position
	%item_menu.position.y += slot_node.size.y
	%item_menu.clear()
	actions = []
	actions_args = []
	
	# If slot allow droping.
	if slot_node.slot.can_drop:
		add_action( "Drop", slot_node.slot.drop_item )
	
	# If it's possible to split.
	if slot_node.slot.can_split and slot_node.slot.item.quantity > 1:
		add_action( "Split", InventoryManager.split.bind( slot_node, slot_node.global_position ) )
	
	# Get the actions of the components.
	for c in slot_node.slot.item.components:
		if not slot_node.slot.item.components[ c ].has_method( "get_action" ):
			continue
		
		var action = slot_node.slot.item.components[ c ].get_action()
		add_action( action.name, action.function )
	
	# Able to sell items if the shop is opened.
	if InventoryManager.is_shop_open:
		add_action( "Sell", slot_node.slot.sell_item )
	
	# If there is actions available.
	if actions.size() > 0:
		%item_menu.popup()
		%item_menu.size = Vector2.ZERO

# Add an action to the list.
# An Action has a name, functions and optional arguments.
func add_action( action_name, action, args = [] ):
	actions.append( action )
	actions_args.append( args )
	%item_menu.add_item( action_name )

# Activate the clicked action.
func _on_PopupMenu_id_pressed( id ):
	actions[ id ].callv( actions_args[ id ] )

# Close the popup if left clicked outside.
func _on_item_menu_window_input( event ):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		%item_menu.hide()














