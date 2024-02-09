class_name SplatterEffect
extends Node2D


signal finished


@export var splatter_color: Color
@export var splatter_sound: AudioStream

@onready var _particle_effect := $ParticleEffect as GPUParticles2D
@onready var _sound_effect := $SoundEffect as AudioStreamPlayer2D


func _ready() -> void:
	_particle_effect.self_modulate = splatter_color
	_sound_effect.stream = splatter_sound


func play() -> void:
	_particle_effect.emitting = true
	_sound_effect.play()

	_all_effects_finished()


func stop() -> void:
	_particle_effect.emitting = false
	_sound_effect.stop()


func _all_effects_finished() -> void:
	await _particle_effect.finished
	await _sound_effect.finished
	
	finished.emit()
