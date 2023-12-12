class_name ProjectileSpawnerComponent
extends Node


## The stats that configure the projectile.
@export var projectile_data: ProjectileData

## Reference to the world scene the game is played in.
var world: World


func spawn(position: Vector2) -> LaserProjectile:
	assert(projectile_data)
	assert(world)
	
	var projectile = projectile_data.scene.instantiate() as LaserProjectile
	projectile.projectile_data = projectile_data
	projectile.position = position
	world.add_child(projectile)

	return projectile
