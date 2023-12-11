class_name Player
extends CharacterBody2D


@export var speed: float = 400.0
@export var projectile_scene: PackedScene

var world: World
var _can_fire: bool = true


func _process(_delta) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	if Input.is_action_pressed("fire"):
		fire()


func fire() -> void:
	if not _can_fire:
		return

	_spawn_projectile()

	$AnimationPlayer.play("fire")
	$Audio/FirePlayer.play()

	_can_fire = false
	$Timers/FiringCooldown.start()


func _spawn_projectile() -> void:
	assert(projectile_scene)
	assert(world)
	
	var projectile = projectile_scene.instantiate() as LaserProjectile
	projectile.position = $MuzzleMarker.global_position
	world.add_child(projectile)


func _on_firing_cooldown_timeout() -> void:
	_can_fire = true
