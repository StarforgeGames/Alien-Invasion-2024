extends Node


signal score_changed(new_score: int)
signal lifes_changed(current_lifes: int)


var world: World
var max_player_lifes: int = 3

var _current_player_lifes: int = max_player_lifes
var current_player_lifes: int:
	get:
		return _current_player_lifes
	set(value):
		_current_player_lifes = value
		lifes_changed.emit(value)

var _score: int = 0
var score: int:
	get:
		return _score
	set(value):
		_score = value
		score_changed.emit(value)


func _ready():	
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu"):
		_toggle_pause_menu()


func _toggle_pause_menu() -> void:
	Ui.toggle_main_menu()
	world.toggle_pause()


func on_player_died() -> void:
	current_player_lifes -= 1

	if current_player_lifes <= 0:
		lost()
	else:
		world.respawn_player()


func won() -> void:
	get_tree().paused = true
	Ui.show_victory_dialog()


func lost() -> void:
	get_tree().paused = true
	Ui.show_defeat_dialog()


func restart() -> void:
	current_player_lifes = max_player_lifes
	score = 0
	world.restart_game()
