class_name Player
extends CharacterBody2D


signal died()


## The movement speed of the player.
@export var speed: float = 400.0

## Reference to the _world scene the game is played in.
var _world: World
var _is_dying = false
var _can_fire: bool = true

@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent


func post_init(world: World):
	_world = world	
	_projectile_spawner_component.world = world


func _process(_delta) -> void:
	if _is_dying:
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	move_and_slide()

	if Input.is_action_pressed("fire"):
		fire()


func fire() -> void:
	if not _can_fire:
		return

	_projectile_spawner_component.spawn($MuzzleMarker.global_position)

	$AnimationPlayer.play("fire")
	$Audio/FirePlayer.play()

	_can_fire = false
	$Timers/FiringCooldown.start()


func _on_firing_cooldown_timeout() -> void:
	_can_fire = true


func _on_died() -> void:
	died.emit()
	_is_dying = true

	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished

	queue_free()
