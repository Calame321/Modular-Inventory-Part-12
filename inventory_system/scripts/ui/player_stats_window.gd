extends UiWindow

@export var player_data : Player_Data

func _ready():
	player_data.equipment.content_changed.connect( _on_content_changed )
	_on_content_changed( player_data.equipment.groups )

# Update the stats when items in the equipmenet group changes.
func _on_content_changed( groups ):
	if groups.find( "equipment" ):
		%lbl_str.text = str( player_data.get_stat( Game_Enums.STAT.STRENGTH ) )
		%lbl_dex.text = str( player_data.get_stat( Game_Enums.STAT.DEXTERITY ) )
		%lbl_int.text = str( player_data.get_stat( Game_Enums.STAT.INTELLIGENCE ) )
		%lbl_vit.text = str( player_data.get_stat( Game_Enums.STAT.VITALITY ) )
		%lbl_move_speed.text = str( player_data.get_stat( Game_Enums.STAT.MOVE_SPEED ) )
