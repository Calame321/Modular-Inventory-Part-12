extends Window

export( NodePath ) onready var lbl_str = get_node( lbl_str ) as Label
export( NodePath ) onready var lbl_dex = get_node( lbl_dex ) as Label
export( NodePath ) onready var lbl_int = get_node( lbl_int ) as Label
export( NodePath ) onready var lbl_vit = get_node( lbl_vit ) as Label
export( NodePath ) onready var lbl_msp = get_node( lbl_msp ) as Label

export( Resource ) var player_data

func _ready():
	player_data.equipment.connect( "content_changed", self, "_on_content_changed" )
	_on_content_changed( player_data.equipment.groups )

# Update the stats when items in the equipmenet group changes.
func _on_content_changed( groups ):
	if groups.find( "equipment" ):
		lbl_str.text = str( player_data.get_stat( Game_Enums.STAT.STRENGTH ) )
		lbl_dex.text = str( player_data.get_stat( Game_Enums.STAT.DEXTERITY ) )
		lbl_int.text = str( player_data.get_stat( Game_Enums.STAT.INTELLIGENCE ) )
		lbl_vit.text = str( player_data.get_stat( Game_Enums.STAT.VITALITY ) )
		lbl_msp.text = str( player_data.get_stat( Game_Enums.STAT.MOVE_SPEED ) )
