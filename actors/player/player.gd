class_name Player
extends CharacterBody2D


signal died()


## The movement speed of the player.
@export var _speed: float = 400.0

## Reference to the _world scene the game is played in.
var _is_invulnerable = false
var _is_dying = false

@onready var _health_component := $Components/HealthComponent as HealthComponent
@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent

@onready var _animation_player := $AnimationPlayer as AnimationPlayer
@onready var _muzzle_marker := $MuzzleMarker as Marker2D
@onready var _death_sound := $Audio/DeathSound as AudioStreamPlayer2D
@onready var _invulernability_timer := $InvulnerabilityTimer as Timer


func _ready() -> void:
	_is_invulnerable = true
	_invulernability_timer.start()

	_projectile_spawner_component.world = Game.world


func _physics_process(_delta) -> void:
	if _is_dying:
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * _speed
	move_and_slide()

	if Input.is_action_pressed("attack"):
		_attack_component.attack(_muzzle_marker.global_position)


func _on_invulnerability_timer_timeout() -> void:
	_is_invulnerable = false


func hit(damage: float) -> void:
	if _is_invulnerable:
		return

	_health_component.current_health -= damage


func _on_died() -> void:
	_is_dying = true
	_is_invulnerable = true

	_animation_player.play("death")
	_death_sound.play()
	await _animation_player.animation_finished
	await _death_sound.finished

	_invulernability_timer.start()
	
	died.emit()
	queue_free()
