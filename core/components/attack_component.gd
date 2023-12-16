class_name AttackComponent
extends Node


@export var _cooldown_time: float = 1.0
@export var _animation_player: AnimationPlayer
@export var _animation_name: StringName = "attack"
@export var _attack_sound: AudioStreamPlayer2D
@export var _projectile_spawner_component: ProjectileSpawnerComponent

var _can_attack: bool = true

@onready var _attack_cooldown := $AttackCooldown as Timer


func _ready() -> void:
	_attack_cooldown.wait_time = _cooldown_time


func attack(spawn_position: Vector2) -> void:
	if not _can_attack:
		return

	_projectile_spawner_component.spawn(spawn_position)

	if _animation_player:
		_animation_player.play(_animation_name)
	if _attack_sound:
		_attack_sound.play()

	_can_attack = false
	_attack_cooldown.start()


func _on_attack_cooldown_timeout() -> void:
	_can_attack = true
