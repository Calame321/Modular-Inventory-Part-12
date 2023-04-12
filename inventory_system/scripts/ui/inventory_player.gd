extends UiWindow

@export var player_data : Player_Data

# Draw the player's inventories from the player's data.
func _ready():
	var equipment_panel = ResourceManager.get_instance( "equipment_node" )
	var inventory_left_panel = ResourceManager.get_instance( "inventory_node" )
	var inventory_right_panel = ResourceManager.get_instance( "inventory_node" )
	%inventory_container.add_child( equipment_panel )
	%inventory_container.add_child( inventory_left_panel )
	%inventory_container.add_child( inventory_right_panel )
	equipment_panel.inventory = player_data.equipment
	inventory_left_panel.inventory = player_data.inventory_left
	inventory_right_panel.inventory = player_data.inventory_right
