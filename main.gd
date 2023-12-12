extends Node


## A reference to the world scene the game will be played in.
@export var world_scene: PackedScene


func _ready() -> void:
	Ui.main_menu.game_started.connect(_on_main_menu_game_started)


func _on_main_menu_game_started() -> void:
	get_tree().change_scene_to_packed(world_scene)
