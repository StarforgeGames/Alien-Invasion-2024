class_name LaserProjectile
extends Area2D


## The stats that configure the laser projectile.
@export var projectile_data: ProjectileData

@onready var _sprite := $Sprite2D as Sprite2D


func _ready() -> void:
	assert(projectile_data, "Projectile Data not assigned")
	assert(projectile_data.sprite, "Laser Projectile sprite not assigned")
	_sprite.texture = projectile_data.sprite


func _physics_process(delta: float) -> void:
	translate(projectile_data.direction * projectile_data.speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit(projectile_data.damage)
	queue_free()


func _on_screen_exited() -> void:
	queue_free()
