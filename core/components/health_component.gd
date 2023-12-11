class_name HealthComponent
extends Node


signal died()

@export var max_health: float

var _current_health: float
var current_health: float:
	get:
		return _current_health
	set(value):
		_current_health = value


func _ready():
	current_health = max_health


func take_damage(damage: float) -> void:
	current_health = max(current_health - damage, 0)

	if current_health <= 0:
		died.emit()