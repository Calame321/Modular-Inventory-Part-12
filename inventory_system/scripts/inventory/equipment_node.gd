class_name Equipment_Node extends Inventory_Node

@export( NodePath ) onready var head = get_node( head ) as Equipment_Slot_Node
@export( NodePath ) onready var chest = get_node( chest ) as Equipment_Slot_Node
@export( NodePath ) onready var offhand = get_node( offhand ) as Equipment_Slot_Node
@export( NodePath ) onready var main_hand = get_node( main_hand ) as Equipment_Slot_Node

func draw_slots():
	head.slot = inventory.slots[ 0 ]
	chest.slot = inventory.slots[ 1 ]
	offhand.slot = inventory.slots[ 2 ]
	main_hand.slot = inventory.slots[ 3 ]
	slots_node.append( head )
	slots_node.append( chest )
	slots_node.append( offhand )
	slots_node.append( main_hand )
