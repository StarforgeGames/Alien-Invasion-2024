class_name LaserProjectile
extends Area2D


## The stats that configure the laser projectile.
@export var projectile_data: ProjectileData

var _rotation_speed: float = 5.0

@onready var _sprite := $Sprite2D as Sprite2D


func _ready() -> void:
	assert(projectile_data, "Projectile Data not assigned")
	assert(projectile_data.sprite, "Laser Projectile sprite not assigned")
	_sprite.texture = projectile_data.sprite
	_sprite.self_modulate = projectile_data.projectile_color


func _physics_process(delta: float) -> void:
	translate(projectile_data.direction * projectile_data.speed * delta)
	_sprite.rotate(_rotation_speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(projectile_data.damage)
	queue_free()


func _on_screen_exited() -> void:
	queue_free()
