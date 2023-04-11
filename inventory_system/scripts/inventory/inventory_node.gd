class_name Inventory_Node extends InnerPanel

## Variables ##
var is_open = false
var slots_node : Array = []
var inventory : Inventory: set = set_inventory

## Setters ##
func set_inventory( value ):
	inventory = value 
	
	if inventory:
		draw_slots()
		set_title( inventory.name )

## Functions ##

# Instanciate each visual slots.
func draw_slots():
	for s in inventory.slots:
		var slot_node = ResourceManager.get_instance( "inventory_slot_node" )
		%slot_container.add_child( slot_node )
		slot_node.slot = s
