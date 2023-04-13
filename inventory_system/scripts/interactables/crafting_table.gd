extends Area2D

@export var crafting_list : String

var action = "craft"
var object_name = crafting_list

# Send the signal that this crafting table has to open.
func interact():
	SignalManager.crafting_opened.emit( crafting_list )

# Send the signal that this crafting table has to close.
func out_of_range():
	SignalManager.crafting_out_of_range.emit()
