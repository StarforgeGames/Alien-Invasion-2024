class_name LaserProjectile
extends Area2D


## The stats that configure the laser projectile.
@export var projectile_data: ProjectileData


func _ready():
	assert(projectile_data, "Projectile Data not assigned")
	assert(projectile_data.sprite, "Laser Projectile sprite not assigned")
	$Sprite2D.texture = projectile_data.sprite


func _physics_process(delta):
	translate(projectile_data.direction * projectile_data.speed * delta)


func _on_body_entered(body: Node2D):
	if "hit" in body:
		body.hit(projectile_data.damage)
	queue_free()


func _on_screen_exited():
	queue_free()
