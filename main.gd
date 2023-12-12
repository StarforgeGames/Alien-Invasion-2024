extends Node


@export var world_scene: PackedScene


func _ready():
	Ui.main_menu.game_started.connect(_on_main_menu_game_started)


func _on_main_menu_game_started():
	get_tree().change_scene_to_packed(world_scene)
