@tool
class_name AlienFleet
extends Node2D


## The movement speed of the alien.
@export var _speed: float = 10.0
## The movement speed increment when the border is reached.
@export var _speed_increment: float = 10.0
## The jump on the vertical axis when the border is reached.
@export var _vertical_jump: float = 20.0

var _direction := Vector2.RIGHT


func _ready() -> void:
	for hammerhead in $Hammerheads.get_children():
		hammerhead.connect("border_reached", _on_border_reached)
		hammerhead.update_movement(_speed, _direction)

	for pincher in $Pinchers.get_children():
		pincher.connect("border_reached", _on_border_reached)
		pincher.update_movement(_speed, _direction)

	for ray in $Rays.get_children():
		ray.connect("border_reached", _on_border_reached)
		ray.update_movement(_speed, _direction)


func _on_border_reached():
	if _direction == Vector2.RIGHT:
		_direction = Vector2.LEFT
	else:
		_direction = Vector2.RIGHT

	_speed += _speed_increment

	for hammerhead in $Hammerheads.get_children():
		hammerhead.update_movement(_speed, _direction)
	
	for pincher in $Pinchers.get_children():
		pincher.update_movement(_speed, _direction)

	for ray in $Rays.get_children():
		ray.update_movement(_speed, _direction)
	
	position += Vector2(0, _vertical_jump)