class_name Player
extends CharacterBody2D


## The movement speed of the player.
@export var speed: float = 400.0
## The stats that configure the laser projectile.
@export var projectile_data: ProjectileData

## Reference to the world scene the game is played in.
var world: World
var _can_fire: bool = true


func _process(_delta) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

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
	assert(projectile_data)
	assert(world)
	
	var projectile = projectile_data.scene.instantiate() as LaserProjectile
	projectile.projectile_data = projectile_data
	projectile.position = $MuzzleMarker.global_position
	world.add_child(projectile)


func _on_firing_cooldown_timeout() -> void:
	_can_fire = true


func _on_died() -> void:
	pass # Replace with function body.
