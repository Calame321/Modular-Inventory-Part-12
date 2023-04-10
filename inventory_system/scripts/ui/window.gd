class_name Window extends Dragable_Control

export( NodePath ) onready var lbl_title = get_node( lbl_title ) as Label

var title setget set_title

func set_title( value ):
	title = value
	lbl_title.text = title

func close():
	hide()

func _on_close_pressed():
	close()
