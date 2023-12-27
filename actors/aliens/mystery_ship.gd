class_name MysteryShip
extends CharacterBody2D


## Horizontal movement speed.
@export var move_speed: float = 175.0
## Frequency of the sine wave movement.
@export var move_frequency: float = 180.0
## Amplitude of the sine wave movement.
@export var move_amplitude: float = 50.0
## Minimum time between mystery ship occurences in seconds.
@export var respawn_min: float = 5.0
## Maximum time between mystery ship occurences in seconds.
@export var respawn_max: float = 20.0

var _time: float = 0.0
var _is_dead = true
var _respawn_pos: Vector2

@onready var sprite := $Sprite2D as Sprite2D
@onready var move_sound := $Audio/MoveSound as AudioStreamPlayer2D
@onready var death_sound := $Audio/DeathSound as AudioStreamPlayer2D
@onready var respawn_timer := $RespawnTimer as Timer


func _ready():
	_respawn_pos = position
	_reset()


func _physics_process(delta) -> void:
	if _is_dead:
		return

	_time += delta

	velocity.x = move_speed
	velocity.y = sin(deg_to_rad(_time * move_frequency)) * move_amplitude

	move_and_slide()


func respawn() -> void:
	_is_dead = false
	move_sound.play()


func _reset() -> void:
	position = _respawn_pos
	_time = 0.0
	move_sound.stop()
	
	respawn_timer.wait_time = randf_range(respawn_min, respawn_max)
	respawn_timer.start()
	

func hit(_damage: float) -> void:
	if _is_dead:
		return

	_is_dead = true
	death_sound.play()
	# TODO: Award points
	await death_sound.finished

	_reset()


func _on_respawn_timer_timeout():
	respawn()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_is_dead = true
	_reset()
