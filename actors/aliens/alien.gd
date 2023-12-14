class_name Alien
extends CharacterBody2D


signal died()


## The movement speed of the alien.
@export var _speed: float = 400.0

## Reference to the _world scene the game is played in.
var _is_dying = false

@onready var _health_component := $Components/HealthComponent as HealthComponent
@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent

@onready var _sprite := $Sprite2D as Sprite2D
@onready var _animation_player := $AnimationPlayer as AnimationPlayer
@onready var _muzzle_marker := $MuzzleMarker as Marker2D
@onready var _death_sound := $Audio/DeathSound as AudioStreamPlayer2D
@onready var _idle_timer := $Timers/IdleTimer as Timer


func _ready() -> void:
	_projectile_spawner_component.world = Game.world
	_health_component.connect("died", _on_died)

	_randomize_idle_timer()


func _randomize_idle_timer() -> void:
	_idle_timer.wait_time = randf_range(4.0, 12.0)


func _physics_process(_delta: float) -> void:
	if _is_dying:
		return

	move_and_slide()


func _on_attack_timer_timeout() -> void:
	if _is_dying:
		return

	_attack_component.attack(_muzzle_marker.global_position)


func _on_idle_timer_timeout() -> void:
	_animation_player.play("idle")
	_randomize_idle_timer()


func hit(damage: float) -> void:
	_health_component.current_health -= damage


func _on_died() -> void:
	_sprite.hide()
	_idle_timer.stop()

	_death_sound.play()
	await _death_sound.finished

	queue_free()