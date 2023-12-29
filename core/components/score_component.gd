class_name ScoreComponent
extends Node


## The amount of score points to be awarded.
@export var score_awarded: int


func award_score() -> void:
	Game.score += score_awarded