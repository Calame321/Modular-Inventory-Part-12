extends Node

const SAVE_FOLDER = "user://save/"
const SAVE_FILE = "save.dat"

var game_data : Game_Data

func _ready():
	game_data = preload( "res://inventory_system/data/resources/game_data.tres" )
	load_game()

func has_save_file():
	return FileAccess.file_exists( SAVE_FOLDER + SAVE_FILE )

func load_game():
	var save_path = SAVE_FOLDER + SAVE_FILE
	if FileAccess.file_exists( save_path ):
		var file = FileAccess.open( save_path, FileAccess.READ )
		var data = file.get_var( true )
		
		if data != null:
			game_data.set_data( data )

func save_game():
	SignalManager.saving_game.emit()
	var dir = DirAccess.open( SAVE_FOLDER )
	
	if not dir:
		DirAccess.make_dir_absolute( SAVE_FOLDER )
		dir = DirAccess.open( SAVE_FOLDER )
	
	var save_path = SAVE_FOLDER + SAVE_FILE
	var file = FileAccess.open( save_path, FileAccess.WRITE )
	file.store_var( game_data.get_data(), true )









