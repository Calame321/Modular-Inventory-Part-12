extends Control

func display( interactable ):
	%action.text = "Press 'e' to " + interactable.action
	%object_name.text = interactable.object_name
	show()
