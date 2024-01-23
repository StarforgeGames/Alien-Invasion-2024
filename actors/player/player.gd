class_name Player
extends CharacterBody2D


signal hit()
signal died()


## The movement speed of the player.
@export var _speed: float = 400.0

@onready var _animation_player := $AnimationPlayer as AnimationPlayer
@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent

@onready var _attack_component := $Components/AttackComponent as AttackComponent
@onready var _hurt_component := $Components/HurtComponent as HurtComponent

@onready var _muzzle_marker := $MuzzleMarker as Marker2D


func _ready() -> void:
	_projectile_spawner_component.world = Game.world


func _physics_process(_delta) -> void:
	if _hurt_component.is_dying:
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * _speed
	move_and_slide()

	if Input.is_action_pressed("attack"):
		_attack_component.attack(_muzzle_marker.global_position)


func _input(event):
	if event.is_action_pressed("move_left"):
		_animation_player.play("tilt_left")
	elif event.is_action_pressed("move_right"):
		_animation_player.play("tilt_right")
	elif event.is_action_released("move_left") or event.is_action_released("move_right"):
		_animation_player.play("RESET")


func take_damage(damage: float) -> void:
	hit.emit()
	_hurt_component.hurt(damage)


func _on_death_finished() -> void:
	died.emit()
	queue_free()
