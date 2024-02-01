class_name AiCamera
extends Node2D


# Speed at which to move through the noise.
@export var noise_shake_speed: float = 30.0
# Multiplier for lerping the shake strength to zero.
@export var shake_decay_rate: float = 5.0

@onready var camera := $Camera2D as Camera2D
@onready var rng := RandomNumberGenerator.new() as RandomNumberGenerator
@onready var noise := FastNoiseLite.new() as FastNoiseLite

# Used to keep track of where we are in the noise so that we can smoothly move through it.
var _noise_y_offset: float = 0.0
var _current_shake_strength: float = 0.0


func _ready() -> void:
	rng.randomize()
	noise.seed = rng.randi()
	noise.frequency = 0.5


func _process(delta: float) -> void:
	# Fade out the intensity over time
	_current_shake_strength = lerpf(_current_shake_strength, 0.0, shake_decay_rate * delta)
	print("Current shake strentgh: " + str(_current_shake_strength))

	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	camera.offset = _get_noise_offset(delta)


func apply_screen_shake(shake_strength: float = 50.0) -> void:
	if shake_strength < _current_shake_strength:
		return
	
	_current_shake_strength = shake_strength


func _get_noise_offset(delta: float) -> Vector2:
	_noise_y_offset += delta * noise_shake_speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, _noise_y_offset) * _current_shake_strength,
		noise.get_noise_2d(100, _noise_y_offset) * _current_shake_strength
	)
