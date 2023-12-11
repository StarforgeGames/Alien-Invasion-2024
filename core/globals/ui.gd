extends CanvasLayer


@export var main_menu: MainMenu


func toggle_main_menu() -> void:
	assert(main_menu)
	if main_menu.visible:
		main_menu.hide()
	else:
		main_menu.show()