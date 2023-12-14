class_name ProjectileSpawnerComponent
extends Node


## The stats that configure the projectile.
@export var _projectile_data: ProjectileData

## Reference to the world scene the game is played in.
var world: World


func spawn(position: Vector2) -> LaserProjectile:
	assert(_projectile_data, "Projectile Data not assigned")
	assert(world, "World not assigned")
	
	var projectile = _projectile_data.scene.instantiate() as LaserProjectile
	projectile.projectile_data = _projectile_data
	projectile.position = position
	world.add_child(projectile)

	return projectile
