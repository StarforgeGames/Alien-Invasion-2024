class_name AlienFleet
extends Node2D


signal defeated()


## The movement speed of the alien.
@export var _speed: float = 10.0
## The movement speed increment when the border is reached.
@export var _speed_increment: float = 5.0
## The jump on the vertical axis when the border is reached.
@export var _vertical_jump: float = 15.0

var _direction := Vector2.RIGHT


func _ready() -> void:
	var aliens = _get_all_aliens()
	for alien: Alien in aliens:
		alien.border_reached.connect(_on_border_reached)
		alien.update_movement(_speed, _direction)


func _get_all_aliens() -> Array[Node]:
	var aliens = $Hammerheads.get_children()
	aliens.append_array($Pinchers.get_children())
	aliens.append_array($Rays.get_children())
	return aliens


func _on_border_reached() -> void:
	if _direction == Vector2.RIGHT:
		_direction = Vector2.LEFT
	else:
		_direction = Vector2.RIGHT

	_speed += _speed_increment

	var aliens = _get_all_aliens()	
	for alien: Alien in aliens:
		alien.update_movement(_speed, _direction)
	
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y + _vertical_jump), 0.2)
	tween.set_ease(Tween.EASE_IN)


func _on_alien_died() -> void:
	if $Hammerheads.get_child_count() == 0 and $Pinchers.get_child_count() == 0 and $Rays.get_child_count() == 0:
		defeated.emit()