@tool
extends EditorScript

	
## Reference to the hammerhead alien scene.
var hammerhead_scene: PackedScene = preload("res://actors/aliens/hammerhead.tscn")
## Number of hammerhead aliens in one column.
var hammerhead_columns: int = 8
## Number of rows with hammerhead aliens.
var hammerhead_rows: int = 2

## Reference to the pincher alien scene.
var pincher_scene: PackedScene = preload("res://actors/aliens/pincher.tscn")
## Number of pincher aliens in one column.
var pincher_columns: int = 12
## Number of rows with pincher aliens.
var pincher_rows: int = 2

## Reference to the ray alien scene.
var ray_scene: PackedScene = preload("res://actors/aliens/ray.tscn")
## Number of ray aliens in one column.
var ray_columns: int = 15
## Number of rows with ray aliens.
var ray_rows: int = 1

var shift_x: float = 40.0
var shift_y: float = 38.0


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var total_rows = hammerhead_rows + pincher_rows + ray_rows

	for r in total_rows:
		var row_index = total_rows - r - 1
		if r < hammerhead_rows:
			_spawn_hammerhead_row(row_index)
		elif r < hammerhead_rows + pincher_rows:
			_spawn_pincher_row(row_index)
		else:
			_spawn_ray_row(row_index)

func _spawn_hammerhead_row(row: int) -> void:
	const margin_x = 13
	const margin_y = 10

	var parent = _get_parent("Hammerheads")

	for c in hammerhead_columns:
		var hammerhead = hammerhead_scene.instantiate() as Alien
		var pos_x: float = (80 + margin_x) * c + shift_x
		var pos_y: float = (75 + margin_y) * row + shift_y
		hammerhead.position = Vector2(pos_x, pos_y)
		
		parent.add_child(hammerhead, true)
		hammerhead.owner = get_scene()


func _spawn_pincher_row(row: int) -> void:
	const margin_x = 9
	const margin_y = 15

	var parent = _get_parent("Pinchers")

	for c in pincher_columns:
		var pincher = pincher_scene.instantiate() as Alien
		var pos_x: float = (50 + margin_x) * c + shift_x
		var pos_y: float = (70 + margin_y) * row + shift_y
		pincher.position = Vector2(pos_x, pos_y)

		parent.add_child(pincher, true)
		pincher.owner = get_scene()


func _spawn_ray_row(row: int) -> void:
	const margin_x = 6.5
	const margin_y = 10

	var parent = _get_parent("Rays")

	for c in ray_columns:
		var ray = ray_scene.instantiate() as Alien
		var pos_x: float = (40 + margin_x) * c + shift_x
		var pos_y: float = (75 + margin_y) * row + shift_y
		ray.position = Vector2(pos_x, pos_y)

		parent.add_child(ray, true)
		ray.owner = get_scene()


func _get_parent(name: NodePath) -> Node2D:
	var parent = get_scene().get_node(name)
	
	if parent:
		return parent
		
	parent = Node2D.new()
	parent.name = name
	get_scene().add_child(parent, true)
	parent.owner = get_scene()
	
	return parent
	
	
