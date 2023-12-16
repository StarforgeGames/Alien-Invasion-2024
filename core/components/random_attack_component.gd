class_name RandomAttackComponent
extends Node


## Parent node containing all the aliens that may randomly attack.
@export var parent: Node2D
## The lower limit for the random attack.
@export var _attack_cooldown_min: float = 5.0
## The upper limit for the random attack.
@export var _attack_cooldown_max: float = 10.0

@onready var _attack_cooldown := $AttackCooldown as Timer


func _ready() -> void:
	_randomize_next_attack_cooldown()
	_attack_cooldown.start()


func _on_attack_cooldown_timeout() -> void:
	var children = parent.get_children()
	
	if children.is_empty():
		_attack_cooldown.stop()
		return

	var aliens: Array[Alien] = []
	aliens.assign(children)

	random_attack(aliens)
	_randomize_next_attack_cooldown()


func random_attack(aliens: Array[Alien]) -> void:
	var alien = aliens[randi_range(0, aliens.size() - 1)]
	alien.attack()


func _randomize_next_attack_cooldown() -> void:
	var cooldown = randf_range(_attack_cooldown_min, _attack_cooldown_max)			
	_attack_cooldown.wait_time = cooldown
