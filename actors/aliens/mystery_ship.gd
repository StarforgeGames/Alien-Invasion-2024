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
var _respawn_pos: Vector2

@onready var _health_component := $Components/HealthComponent as HealthComponent
@onready var _hurt_component := $Components/HurtComponent as HurtComponent
@onready var _score_component := $Components/ScoreComponent as ScoreComponent

@onready var _sprite := $Sprite2D as Sprite2D
@onready var _collision_shape := $CollisionShape2D as CollisionShape2D
@onready var _move_sound := $Audio/MoveSound as AudioStreamPlayer2D
@onready var _respawn_timer := $RespawnTimer as Timer


func _ready() -> void:
	_health_component.died.connect(_score_component.award_score)

	_respawn_pos = position
	_reset()


func _physics_process(delta) -> void:
	if _hurt_component.is_dying:
		return

	_time += delta

	velocity.x = move_speed
	velocity.y = sin(deg_to_rad(_time * move_frequency)) * move_amplitude

	move_and_slide()


func respawn() -> void:
	_hurt_component.is_dying = false
	_move_sound.play()


func _reset() -> void:
	position = _respawn_pos
	_time = 0.0
	_move_sound.stop()

	_health_component.current_health = 1
	_hurt_component.is_dying = true
	_hurt_component.is_invulnerable = false
	_sprite.show()
	_collision_shape.disabled = false
	
	_respawn_timer.wait_time = randf_range(respawn_min, respawn_max)
	_respawn_timer.start()
	

func hit(_damage: float) -> void:
	_hurt_component.hurt(99)
	_move_sound.stop()


func _on_death_finished():
	_reset()


func _on_respawn_timer_timeout() -> void:
	respawn()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_hurt_component.is_dying = true
	_reset()
