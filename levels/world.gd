class_name World
extends Node2D


## Reference to the player scene for spawning.
@export var _player_scene: PackedScene
## Position where the player spawns into the world.
@export var _player_start: Marker2D

var _player: Player

@onready var hud := $HUD as HUD
@onready var _camera := $AiCamera as AiCamera
@onready var _player_respawn_timer := $PlayerRespawnTimer as Timer
@onready var _alien_fleet := $AlienFleet as AlienFleet
@onready var _mystery_ship := $MysteryShip as MysteryShip


func _init() -> void:
	Game.world = self


func _ready() -> void:
	get_tree().paused = false

	Ui.main_menu.game_started.connect(restart_game)
	Game.lifes_changed.connect(hud.update_lifes)
	Game.score_changed.connect(hud.update_score)

	hud.update_lifes(Game.current_player_lifes)
	hud.update_score(Game.score)

	_alien_fleet.defeated.connect(Game.won)
	_alien_fleet.alien_hit.connect(_on_alien_hit)
	_mystery_ship.hit.connect(_on_mystery_ship_hit)

	_spawn_player()


func _spawn_player() -> void:
	assert(_player_scene, "Player Scene not assigned")
	assert(_player_start, "Player Start not assigned")

	_player = _player_scene.instantiate() as Player
	_player.position = _player_start.global_position
	_player.hit.connect(_on_player_hit)
	_player.died.connect(Game.on_player_died)
	add_child(_player)


func respawn_player() -> void:
	_player_respawn_timer.start()


func _on_player_respawn_timer_timeout() -> void:
	_spawn_player()


func _on_player_hit():
	_camera.apply_screen_shake()


func _on_alien_hit():
	_camera.apply_screen_shake(3.0)


func _on_mystery_ship_hit():
	_camera.apply_screen_shake(10.0)


func restart_game() -> void:
	get_tree().reload_current_scene()


func toggle_pause():	
	get_tree().paused = not get_tree().paused
