class_name ProjectileData
extends Resource


## Reference to the projectile scene.
@export var scene: PackedScene
## Path to the sprite to use for visuals.
@export var sprite: Texture2D
## The movement speed of the projectile.
@export var speed := 1000
## The direction in which the projectile will move.
@export var direction := Vector2.UP
## The amount of damage inflicted by this projectile
@export var damage: float = 1.0