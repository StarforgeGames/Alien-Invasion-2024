class_name Alien
extends CharacterBody2D


signal border_reached()
signal hit()
signal died()

enum AlienUnit { Hammerhead, Pincher, Ray }

const BORDER_MARGIN = 30.0

@export var alien_unit: AlienUnit

var _speed: float
var _direction: Vector2

@onready var _health_component := $Components/HealthComponent as HealthComponent
@onready var _hurt_component := $Components/HurtComponent as HurtComponent
@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent
@onready var _score_component := $Components/ScoreComponent as ScoreComponent

@onready var _animation_player := $AnimationPlayer as AnimationPlayer
@onready var _muzzle_marker := $MuzzleMarker as Marker2D
@onready var _idle_timer := $Timers/IdleTimer as Timer


func _ready() -> void:
	_projectile_spawner_component.world = Game.world
	_health_component.died.connect(_score_component.award_score)

	_randomize_idle_timer()
	_idle_timer.start()


func _physics_process(delta: float) -> void:
	if _hurt_component.is_dying:
		return

	velocity = _direction * _speed
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision and collision.get_collider() is Player:
		Game.lost()

	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	if global_position.x < BORDER_MARGIN or global_position.x > (viewport_width - BORDER_MARGIN):
		border_reached.emit()


func update_movement(speed: float, direction: Vector2):
	_speed = speed
	_direction = direction


func attack() -> void:
	if _hurt_component.is_dying:
		return
		
	_attack_component.attack(_muzzle_marker.global_position)


func take_damage(damage: float) -> void:
	hit.emit()
	_hurt_component.hurt(damage)


func _randomize_idle_timer() -> void:
	_idle_timer.wait_time = randf_range(2.0, 15.0)


func _on_idle_timer_timeout() -> void:
	if _hurt_component.is_dying:		
		_idle_timer.stop()
		return

	_animation_player.play("idle")
	_randomize_idle_timer()


func _on_death_finished() -> void:
	died.emit()
	queue_free()