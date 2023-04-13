extends Node

var fullscreen : set = set_fullscreen
var scale : set = set_scale
var settings_data : Settings_Data

func _ready():
	settings_data = preload( "res://inventory_system/data/resources/settings_data.tres" )
	scale = settings_data.scale
	fullscreen = settings_data.fullscreen
	settings_data.changed.connect( _on_data_changed )

func set_fullscreen( value ):
	fullscreen = value
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (value) else Window.MODE_WINDOWED
	settings_data.fullscreen = value

func set_scale( value ):
	scale = value
	SignalManager.ui_scale_changed.emit( value )
	settings_data.scale = value

func _on_data_changed():
	set_fullscreen( settings_data.fullscreen )
	set_scale( settings_data.scale )
