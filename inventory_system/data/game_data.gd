class_name Game_Data extends Resource

@export var settings_data : Settings_Data
@export var player_data : Player_Data

# Set the data from a Dictionary.
func set_data( data ):
	settings_data.set_data( data.settings_data )
	player_data.set_data( data.player_data )
	emit_changed()

# Pack the data in a Dictionary.
func get_data():
	return {
		"settings_data": settings_data.get_data(),
		"player_data": player_data.get_data()
	}
