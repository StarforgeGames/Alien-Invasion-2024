class_name Player
extends CharacterBody2D


signal died()


## The movement speed of the player.
@export var _speed: float = 400.0

## Reference to the _world scene the game is played in.
var _is_dying = false

@onready var _health_component := $Components/HealthComponent as HealthComponent
@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent

@onready var _animation_player := $AnimationPlayer as AnimationPlayer
@onready var _muzzle_marker := $MuzzleMarker as Marker2D
@onready var _death_sound := $Audio/DeathSound as AudioStreamPlayer2D


func _ready():
	_projectile_spawner_component.world = Game.world

	_health_component.connect("died", _on_died)


func _physics_process(_delta) -> void:
	if _is_dying:
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * _speed
	move_and_slide()

	if Input.is_action_pressed("attack"):
		_attack_component.attack(_muzzle_marker.global_position)


func hit(damage: float) -> void:
	_health_component.current_health -= damage


func _on_died() -> void:
	died.emit()
	_is_dying = true

	_animation_player.play("death")
	_death_sound.play()
	await _animation_player.animation_finished
	await _death_sound.finished

	queue_free()
