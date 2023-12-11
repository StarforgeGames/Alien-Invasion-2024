extends Node


@export var world_scene: PackedScene

var _world: World


func _ready():
	Ui.main_menu.game_started.connect(_on_main_menu_game_started)
	Ui.main_menu.quit.connect(_on_main_menu_quit)


func _on_main_menu_game_started():
	_start_game()


func _start_game():
	if _world:
		_world.queue_free()

	_world = world_scene.instantiate() as World
	add_child(_world)

	
func _on_main_menu_quit():
	get_tree().quit()
	

func _process(_delta):
	if Input.is_action_just_pressed("toggle_pause_menu"):
		_toggle_pause_menu()


func _toggle_pause_menu():
	if not _world:
		return

	Ui.toggle_main_menu()
	_world.get_tree().paused = not _world.get_tree().paused