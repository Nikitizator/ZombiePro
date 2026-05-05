extends CharacterBody2D


const SPEED = 200.0


func _physics_process(delta: float):
	
	move_and_collide(Vector2.UP * SPEED * delta)
	
