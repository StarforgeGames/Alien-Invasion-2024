extends Node2D


var _player_scene: PackedScene = preload("res://actors/player/player.tscn")
var _player


func _ready():
	_spawn_player()


func _spawn_player():
	_player = _player_scene.instantiate()
	_player.position = Vector2(512, 650)
	add_child(_player)