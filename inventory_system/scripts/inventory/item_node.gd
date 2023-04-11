class_name Item_Node extends TextureRect

@export ( NodePath ) onready var lbl_quantity = get_node( lbl_quantity ) as Label

var item : Item

# Draw the item and connect signals.
func _ready():
	_on_quantity_changed( item.quantity )
	item.connect("quantity_changed", Callable(self, "_on_quantity_changed"))
	item.connect("depleted", Callable(self, "_on_depleted"))
	
	if item.components.has( "usable" ):
		SignalManager.connect("cooldown_started", Callable(self, "_on_cooldown_started"))
		
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
	lbl_quantity.text = str( value )
	lbl_quantity.visible = value > 1
