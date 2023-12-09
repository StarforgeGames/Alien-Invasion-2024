extends Node


@onready var _main_menu = $MainMenu
@onready var _world = $World


func _ready():
	pass


func start_game():
	remove_child(_main_menu)
	add_child(_world)


func show_menu():
	remove_child(_world)
	add_child(_main_menu)


func _on_main_menu_game_started():
	start_game()

	
func _on_main_menu_quit():
	get_tree().quit()
