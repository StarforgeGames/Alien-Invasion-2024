extends Control


signal game_started()
signal quit()


func _ready():
	pass


func _on_new_game_button_pressed():
	game_started.emit()


func _on_quit_button_pressed():
	quit.emit()
