class_name Settings_Data extends Resource

@export var fullscreen : bool = true
@export var scale : float = 1

# Set the data from a Dictionary.
func set_data( data ):
	fullscreen = data.fullscreen
	scale = data.scale
	emit_changed()

# Pack the data in a Dictionary.
func get_data():
	return {
		"fullscreen": fullscreen,
		"scale": scale
	}
