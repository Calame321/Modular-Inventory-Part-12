extends Node

const SAVE_FOLDER = "user://save/"
const SAVE_FILE = "save.dat"

var game_data : Game_Data

func _ready():
	game_data = preload( "res://inventory_system/data/resources/game_data.tres" )
	load_game()

func has_save_file():
	var file = File.new()
	return file.file_exists( SAVE_FOLDER + SAVE_FILE )

func load_game():
	var file = File.new()
	var save_path = SAVE_FOLDER + SAVE_FILE
	if file.file_exists( save_path ):
		file.open( save_path, File.READ )
		var data = file.get_var( true )
		file.close()
		
		if data != null:
			game_data.set_data( data )

func save_game():
	SignalManager.emit_signal( "saving_game" )
	var dir = DirAccess.new()
	
	if not dir.dir_exists( SAVE_FOLDER ):
		dir.make_dir_recursive( SAVE_FOLDER )
	
	var file = File.new()
	var save_path = SAVE_FOLDER + SAVE_FILE
	file.open( save_path, File.WRITE )
	file.store_var( game_data.get_data(), true )
	file.close()









