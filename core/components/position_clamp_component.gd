class_name PositionClampComponent
extends Node

# Actor who's position will be clamped
@export var actor: Node2D

# Margin for left and right (margin.x) and top and bottom (margin.y)
@export var margin: float = 20.0

# Define the left and right borders to bounce on
var left_border: float = 0
# Use the display viewport width to get the right border of the screen
var right_border: float = ProjectSettings.get_setting("display/window/size/viewport_width")

func _physics_process(_delta: float) -> void:
	actor.global_position.x = clamp(actor.global_position.x, left_border + margin, right_border - margin)