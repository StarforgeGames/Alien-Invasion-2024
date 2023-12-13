class_name Alien
extends CharacterBody2D


signal died()


## The movement speed of the alien.
@export var speed: float = 400.0

## Reference to the _world scene the game is played in.
var _world: World
var _is_dying = false

@onready var _projectile_spawner_component := $Components/ProjectileSpawnerComponent as ProjectileSpawnerComponent
@onready var _attack_component := $Components/AttackComponent as AttackComponent


func _ready():
	_randomize_idle_timer()


func post_init(world: World):
	_world = world	
	_projectile_spawner_component.world = world


func _randomize_idle_timer():
	$Timers/IdleTimer.wait_time = randf_range(4.0, 12.0)


func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_attack_timer_timeout():
	_attack_component.attack($MuzzleMarker.global_position)


func _on_idle_timer_timeout():
	$AnimationPlayer.play("idle")
	_randomize_idle_timer()

