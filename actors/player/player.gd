extends CharacterBody2D


const SPEED = 400.0

var _can_fire: bool = true


func _process(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if Input.is_action_pressed("fire"):
		fire()


func fire():
	if not _can_fire:
		return

	$AnimationPlayer.play("fire")
	$Audio/FirePlayer.play()

	_can_fire = false
	$Timers/FiringCooldown.start()


func _on_firing_cooldown_timeout():
	_can_fire = true
