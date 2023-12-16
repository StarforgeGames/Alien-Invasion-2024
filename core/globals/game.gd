extends Node


var world: World
var max_player_lives: int = 3
var current_player_lives: int = max_player_lives


func on_player_died() -> void:
	current_player_lives -= 1
	print("Current lives: " + str(current_player_lives))
	if current_player_lives < 0:
		lost()
	else:
		print("Respawning...")
		world.respawn_player()


func won() -> void:
	get_tree().paused = true
	print("You won!")


func lost() -> void:
	get_tree().paused = true
	print("You lost!")