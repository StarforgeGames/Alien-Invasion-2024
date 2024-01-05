class_name CreditsMenu
extends Control


## Duration in seconds how long the text will need to roll.
@export var roll_duration: float = 25.0
## Margin added on top of the text size to ensure it's outside of the screen when the rolling ends.
@export var margin_y = 50.0

var start_pos: Vector2
var end_pos: Vector2

@onready var credits_label := $RichTextLabel as RichTextLabel
@onready var rolling_tween: Tween


func _ready() -> void:
	start_pos = credits_label.position
	end_pos = Vector2(0, -credits_label.size.y - margin_y)


func _on_back_button_pressed() -> void:
	hide()


func _on_visibility_changed() -> void:
	if visible:
		credits_label.position = start_pos
		_roll_credits()
	elif rolling_tween:	
		rolling_tween.kill()


func _roll_credits() -> void:
	rolling_tween = create_tween()
	rolling_tween.tween_property($RichTextLabel, "position", end_pos, roll_duration)