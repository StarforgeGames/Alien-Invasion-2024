extends StaticBody2D


@onready var _sprite := $Sprite2D as Sprite2D
@onready var _health_component := $Components/HealthComponent as HealthComponent


func hit(damage:float) -> void:
	_health_component.current_health -= damage


func _on_died() -> void:
	queue_free()


func _on_damaged(new_health: float) -> void:
	print("damaged, new health: " + str(new_health))
	match new_health:
		1.0:
			_sprite.frame = 2
		2.0:
			_sprite.frame = 1
		3.0:
			_sprite.frame = 0
