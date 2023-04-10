extends Window

export( NodePath ) onready var inventory_container = get_node( inventory_container ) as Control

var current_inventory

func _ready():
	SignalManager.connect( "inventory_opened", self, "_on_inventory_opened" )
	SignalManager.connect( "inventory_closed", self, "_on_inventory_closed" )

# Remove the inventory node when closed.
func close():
	for c in inventory_container.get_children():
		c.queue_free()
	current_inventory = null
	hide()

# When an inventory is opened, display it in the pannel.
func _on_inventory_opened( inventory : Inventory ):
	if current_inventory == inventory:
		return
	
	var node = ResourceManager.get_instance( "inventory_node" )
	inventory_container.add_child( node )
	node.inventory = inventory
	current_inventory = inventory
	show()

func _on_inventory_closed( inventory : Inventory ):
	close()
