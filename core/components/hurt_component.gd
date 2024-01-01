class_name HurtComponent
extends Node2D


## Emitted when all death effects have finished.
signal death_finished()


## Time before invulnerability ends.
@export var _invulernability_time: float = 1.0

@export var _health_component: HealthComponent
@export var _collision_shape: CollisionShape2D
@export var _death_animation_player: AnimationPlayer
@export var _death_animation_name: StringName = "death"
@export var _death_sound: AudioStreamPlayer2D

var is_dying = false

var _is_invulnerable = false
var is_invulnerable:
	get:
		return _is_invulnerable
	set (value):
		_is_invulnerable = value

		if _collision_shape:
			call_deferred("_set_collision", _is_invulnerable)

@onready var _invulernability_timer := $InvulnerabilityTimer as Timer


func _ready():
	_health_component.died.connect(_on_died)
	_invulernability_timer.wait_time = _invulernability_time

	is_invulnerable = true
	_invulernability_timer.start()


func hurt(damage: float) -> void:
	if is_invulnerable or is_dying:
		return

	_health_component.current_health -= damage


func _set_collision(disabled: bool):
	_collision_shape.disabled = disabled
	

func _on_died() -> void:
	is_dying = true
	is_invulnerable = true

	if _death_animation_player:
		_death_animation_player.play(_death_animation_name)

	if _death_sound:
		_death_sound.play()
		
	if _death_animation_player:
		await _death_animation_player.animation_finished
	
	if _death_sound:
		await _death_sound.finished
	
	death_finished.emit()


func _on_invulnerability_timer_timeout():
	is_invulnerable = false
