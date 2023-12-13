class_name Player
extends CharacterBody2D


signal died()


## The movement speed of the player.
@export var speed: float = 400.0

## Reference to the _world scene the game is played in.
var _world: World
var _is_dying = false

@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent


func post_init(world: World):
	_world = world	
	_projectile_spawner_component.world = world


func _physics_process(_delta) -> void:
	if _is_dying:
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	move_and_slide()

	if Input.is_action_pressed("attack"):
		_attack_component.attack($MuzzleMarker.global_position)


func _on_died() -> void:
	died.emit()
	_is_dying = true

	$AnimationPlayer.play("death")
	$Audio/DeathSound.play()
	await $AnimationPlayer.animation_finished

	queue_free()
