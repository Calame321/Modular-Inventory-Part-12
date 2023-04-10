extends Control

export( NodePath ) onready var settings = get_node( settings ) as Control
export( NodePath ) onready var player_inventory = get_node( player_inventory ) as Control

func _input( event ):
	if event.is_action_pressed( "inventory" ):
		player_inventory.visible = not player_inventory.visible

func _on_settings_pressed():
	settings.visible = ! settings.visible
	settings.raise()

func _on_quit_pressed():
	get_tree().quit()

func _on_save_pressed():
	SaveManager.save_game()

func _on_load_pressed():
	SaveManager.load_game()
