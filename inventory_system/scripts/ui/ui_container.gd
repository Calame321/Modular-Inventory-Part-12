extends Control

func _input( event ):
	if event.is_action_pressed( "inventory" ):
		%inventory_player.visible = not player_inventory.visible

func _on_settings_pressed():
	%settings.visible = ! %settings.visible
	%settings.move_to_front()

func _on_quit_pressed():
	get_tree().quit()

func _on_save_pressed():
	SaveManager.save_game()

func _on_load_pressed():
	SaveManager.load_game()
