extends Area2D

@export var crafting_list : String

var action = "craft"
var object_name = crafting_list

# Send the signal that this crafting table has to open.
func interact():
	SignalManager.emit_signal( "crafting_opened", crafting_list )

# Send the signal that this crafting table has to close.
func out_of_range():
	SignalManager.emit_signal( "crafting_out_of_range" )
