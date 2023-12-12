class_name World
extends Node2D


@export var _player_scene: PackedScene

var _player: Player


func _ready():
	get_tree().paused = false
	_spawn_player()
	Ui.main_menu.game_started.connect(_on_main_menu_restart_game)


func _spawn_player():
	assert(_player_scene)
	_player = _player_scene.instantiate() as Player
	_player.position = Vector2(512, 650)
	_player.world = self
	add_child(_player)


func _on_main_menu_restart_game():
	get_tree().reload_current_scene()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu"):
		_toggle_pause_menu()


func _toggle_pause_menu():
	Ui.toggle_main_menu()
	get_tree().paused = not get_tree().paused