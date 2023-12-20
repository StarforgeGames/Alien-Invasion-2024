extends ColorRect


func _on_continue_button_pressed():
	_save_highscore()
	hide()
	Ui.load_main_menu()


func _on_play_again_button_pressed():
	_save_highscore()
	hide()
	Game.restart()


func _save_highscore():
	pass