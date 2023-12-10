extends CanvasLayer


@onready var main_menu = $MainMenu


func toggle_main_menu():
	if $MainMenu.visible:
		$MainMenu.hide()
	else:
		$MainMenu.show()