class_name MainMenu
extends Control


## Emitted when the game should be started.
signal game_started()


func _on_new_game_button_pressed() -> void:
	game_started.emit()
	hide()


func _on_high_score_button_pressed() -> void:
	Ui.show_high_score_menu()


func _on_credits_button_pressed():
	Ui.show_credits_menu()
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	$MenuMusic.stream_paused = not visible
