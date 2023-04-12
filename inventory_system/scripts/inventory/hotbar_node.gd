class_name Hotbar_Node extends Control

@export var player_data : Player_Data

var slots : Array = []

# Draw the hotbar slot from the player data.
func _ready():
	for slot in player_data.hotbar.slots:
		var slot_node = ResourceManager.get_instance( "hotbar_slot_node" )
		%slot_container.add_child( slot_node )
		slot_node.slot = slot
		slots.append( slot )
