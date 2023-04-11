class_name Equipment_Node extends Inventory_Node

func draw_slots():
	%equipment_head.slot = inventory.slots[ 0 ]
	%equipment_chest.slot = inventory.slots[ 1 ]
	%equipment_offhand.slot = inventory.slots[ 2 ]
	%equipment_main_hand.slot = inventory.slots[ 3 ]
	slots_node.append( %equipment_head )
	slots_node.append( %equipment_chest )
	slots_node.append( %equipment_offhand )
	slots_node.append( %equipment_main_hand )
