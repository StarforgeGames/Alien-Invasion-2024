class_name LaserProjectile
extends Area2D


@export var speed: int = 1000

var _direction: Vector2 = Vector2.UP


func _ready():
    #$SelfDestructTimer.start()
    pass


func _process(delta):    
    position += _direction * speed * delta


func _on_body_entered(body: Node2D):
    if "hit" in body:
        body.hit()
    queue_free()


func _on_self_destruct_timer_timeout():
    queue_free()
