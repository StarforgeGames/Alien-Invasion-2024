extends CanvasLayer


## Scene of the main menu.
var _main_scene: String = "res://main.tscn"

## The games' main menu.
@onready var main_menu := $MainMenu as MainMenu
## The high score menu screen.
@onready var high_score_menu := $HighScoreMenu as HighScoreMenu
## The dialog shown when the game is lost.
@onready var _defeat_dialog := $DefeatDialog as ColorRect
## The dialog shown when the game is won.
@onready var _victory_dialog := $VictoryDialog as ColorRect


func _ready() -> void:
	_defeat_dialog.hide()
	_victory_dialog.hide()
	main_menu.show()


func show_high_score_menu():
	high_score_menu.show()


func show_victory_dialog() -> void:
	_victory_dialog.show()


func show_defeat_dialog() -> void:
	_defeat_dialog.show()


func toggle_main_menu() -> void:
	if main_menu.visible:
		main_menu.hide()
	else:
		main_menu.show()


func load_main_menu():	
	get_tree().change_scene_to_file(_main_scene)