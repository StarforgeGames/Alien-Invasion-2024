class_name World
extends Node2D


## Reference to the player scene for spawning.
@export var _player_scene: PackedScene
## Position where the player spawns into the world.
@export var _player_start: Marker2D

var _player: Player

@onready var _player_respawn_timer := $PlayerRespawnTimer as Timer


func _init() -> void:
	Game.world = self


func _ready() -> void:
	get_tree().paused = false
	Ui.main_menu.game_started.connect(_on_main_menu_restart_game)

	_spawn_player()


func _spawn_player() -> void:
	assert(_player_scene, "Player Scene not assigned")
	assert(_player_start, "Player Start not assigned")

	_player = _player_scene.instantiate() as Player
	_player.position = _player_start.global_position
	add_child(_player)


func _on_player_died():
	_player_respawn_timer.start()


func _on_player_respawn_timer_timeout():
	_spawn_player()


func _on_main_menu_restart_game() -> void:
	get_tree().reload_current_scene()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu"):
		_toggle_pause_menu()


func _toggle_pause_menu() -> void:
	Ui.toggle_main_menu()
	get_tree().paused = not get_tree().paused