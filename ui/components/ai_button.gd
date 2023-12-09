extends TextureButton


func _on_pressed():
	$ButtonPressedPlayer.play()


func _on_mouse_entered():
	$ButtonHoveredPlayer.play()
