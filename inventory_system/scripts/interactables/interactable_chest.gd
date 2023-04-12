class_name Chest extends Area2D

# Item that will be picked randomly.
@export var loot_table : Array[ String ]

# The Inventory data.
@export var inventory : Inventory

# The action shown in the interactable text.
var action = "open"

# The name of the object shown in the interactable text.
var object_name = "Chest"

func _ready():
	object_name = inventory.name
	set_items()

# Generate the items in the chest.
func set_items():
	for i in loot_table:
		inventory.add_item( ItemManager.get_item( i ) )

# Sent the signal to show the content of the chest.
func interact():
	SignalManager.emit_signal( "inventory_opened", inventory )

# Close the chest when too far away.
func out_of_range():
	SignalManager.emit_signal( "inventory_closed", inventory )
