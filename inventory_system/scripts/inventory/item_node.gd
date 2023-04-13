class_name Item_Node extends TextureRect

var item : Item

# Draw the item and connect signals.
func _ready():
	_on_quantity_changed( item.quantity )
	item.quantity_changed.connect( _on_quantity_changed )
	item.depleted.connect( _on_depleted )
	
	if item.components.has( "usable" ):
		SignalManager.cooldown_started.connect( _on_cooldown_started )
		
		if item.components.usable.is_in_cooldown:
			set_cooldown()

# Add an instance of the cooldown node.
func set_cooldown():
	var cooldown_node = ResourceManager.get_instance( "cooldown" )
	cooldown_node.set_data( item.components.usable )
	add_child( cooldown_node )

# If a cooldown has started and it's affecting this item, set the cooldown.
func _on_cooldown_started( usable ):
	if item.components.has( "usable" ) and item.components.usable == usable:
		set_cooldown()

# If the item is depleted, remove this node.
func _on_depleted():
	queue_free()

# Update the quantity label when it changes.
func _on_quantity_changed( value ):
	%quantity.text = str( value )
	%quantity.visible = value > 1
