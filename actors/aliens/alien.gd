class_name Alien
extends CharacterBody2D


signal border_reached()
signal died()

enum AlienUnit { Hammerhead, Pincher, Ray }

const BORDER_MARGIN = 30.0

@export var alien_unit: AlienUnit

var _speed: float
var _direction: Vector2

## Reference to the _world scene the game is played in.
var _is_dying = false

@onready var _health_component := $Components/HealthComponent as HealthComponent
@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent

@onready var _sprite := $Sprite2D as Sprite2D
@onready var _collision_shape := $CollisionShape2D as CollisionShape2D
@onready var _animation_player := $AnimationPlayer as AnimationPlayer
@onready var _muzzle_marker := $MuzzleMarker as Marker2D
@onready var _death_sound := $Audio/DeathSound as AudioStreamPlayer2D
@onready var _idle_timer := $Timers/IdleTimer as Timer


func _ready() -> void:
	_projectile_spawner_component.world = Game.world
	_health_component.died.connect(_on_died)

	_randomize_idle_timer()
	_idle_timer.start()


func _physics_process(delta: float) -> void:
	if _is_dying:
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
	if _is_dying:
		return
		
	_attack_component.attack(_muzzle_marker.global_position)


func hit(damage: float) -> void:
	_health_component.current_health -= damage


func _randomize_idle_timer() -> void:
	_idle_timer.wait_time = randf_range(2.0, 15.0)


func _on_idle_timer_timeout() -> void:
	_animation_player.play("idle")
	_randomize_idle_timer()


func _on_died() -> void:
	_sprite.hide()
	_idle_timer.stop()

	call_deferred("_kill")

func _kill() -> void:
	_collision_shape.disabled = true
	_death_sound.play()
	await _death_sound.finished

	queue_free()
	died.emit()