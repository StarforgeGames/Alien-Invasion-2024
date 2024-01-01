extends ColorRect


func _on_continue_button_pressed() -> void:
	hide()
	Ui.load_main_menu()


func _on_play_again_button_pressed() -> void:
	hide()
	Game.restart()
