class_name Window extends Dragable_Control

var title : set = set_title

func set_title( value ):
	title = value
	%title.text = title

func close():
	hide()

func _on_close_pressed():
	close()
