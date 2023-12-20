class_name HUD
extends CanvasLayer


@onready var _player_stats := $PlayerStats as ColorRect
@onready var _lives_value_label := %LivesValueLabel as Label
@onready var _score_value_label := %ScoreValueLabel as Label


func _ready():
	_player_stats.show()


func update_lives(lives: int):
	_lives_value_label.text = str(lives)


func update_score(score: int):
	_score_value_label.text = str(score)