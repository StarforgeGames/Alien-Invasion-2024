extends TextureButton


func _on_pressed() -> void:
	$ButtonPressedPlayer.play()


func _on_mouse_entered() -> void:
	$ButtonHoveredPlayer.play()
