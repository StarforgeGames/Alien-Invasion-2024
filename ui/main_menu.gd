extends Control


signal game_started()
signal quit()


func _on_new_game_button_pressed() -> void:
	game_started.emit()
	hide()


func _on_quit_button_pressed() -> void:
	quit.emit()


func _on_visibility_changed():
	$MenuMusic.stream_paused = not visible
