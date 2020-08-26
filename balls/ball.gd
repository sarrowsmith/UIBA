extends RigidBody2D


func _on_Timer_timeout():
	if not sleeping:
		apply_central_impulse(Vector2(rand_range(-100, +100), rand_range(-100, +100)))
