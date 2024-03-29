class_name HealthComponent
extends Node


## Emitted when the health reaches 0 and the owning actor dies.
signal damaged(new_health: float)
## Emitted when the health reaches 0 and the owning actor dies.
signal died()

## The maximum amount of health the owner can have.
@export var max_health: float = 1.0

var _current_health: float
## The current amount of health the owner has.
var current_health: float:
	get:
		return _current_health
	set(value):
		if _current_health > value:			
			damaged.emit(value)

		_current_health = value

		if _current_health <= 0:
			died.emit()


func _ready() -> void:
	current_health = max_health