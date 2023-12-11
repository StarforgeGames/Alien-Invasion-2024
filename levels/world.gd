class_name World
extends Node2D


@export var _player_scene: PackedScene

var _player: Player


func _ready():
	_spawn_player()


func _spawn_player():
	assert(_player_scene)
	_player = _player_scene.instantiate() as Player
	_player.position = Vector2(512, 650)
	_player.world = self
	add_child(_player)