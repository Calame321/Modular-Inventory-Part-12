extends Node

var fullscreen setget set_fullscreen
var scale setget set_scale
var settings_data : Settings_Data

func _ready():
	settings_data = preload( "res://inventory_system/data/resources/settings_data.tres" )
	scale = settings_data.scale
	fullscreen = settings_data.fullscreen
	settings_data.connect( "changed", self, "_on_data_changed" )

func set_fullscreen( value ):
	fullscreen = value
	OS.window_fullscreen = value
	settings_data.fullscreen = value

func set_scale( value ):
	scale = value
	SignalManager.emit_signal( "ui_scale_changed", value )
	settings_data.scale = value

func _on_data_changed():
	set_fullscreen( settings_data.fullscreen )
	set_scale( settings_data.scale )
