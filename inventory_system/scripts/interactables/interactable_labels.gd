extends Scale_Control

export( NodePath ) onready var lbl_action = get_node( lbl_action ) as Label
export( NodePath ) onready var lbl_name = get_node( lbl_name ) as Label

func display( interactable ):
	lbl_action.text = "Press 'e' to " + interactable.action
	lbl_name.text = interactable.object_name
	show()
