extends Node


var world: World
var max_player_lives: int = 3
var current_player_lives: int = max_player_lives
var score: int = 0


func _ready():	
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu"):
		_toggle_pause_menu()


func _toggle_pause_menu() -> void:
	Ui.toggle_main_menu()
	world.toggle_pause()


func on_player_died() -> void:
	current_player_lives -= 1
	world.hud.update_lives(current_player_lives)

	if current_player_lives <= 0:
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
	current_player_lives = max_player_lives
	score = 0
	world.restart_game()