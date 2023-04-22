class_name Settings_Data extends Resource

@export var fullscreen : bool = true
@export var ui_scale : float = 1

# Set the data from a Dictionary.
func set_data( data ):
	fullscreen = data.fullscreen
	ui_scale = data.ui_scale
	emit_changed()

# Pack the data in a Dictionary.
func get_data():
	return {
		"fullscreen": fullscreen,
		"ui_scale": ui_scale
	}
