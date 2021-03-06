extends RigidBody2D


signal ball_hit(string)

var sound_map = {}
var last_hit = null


func _on_Timer_timeout():
	if not sleeping:
		apply_central_impulse(Vector2(rand_range(-100, +100), rand_range(-100, +100)))


func _on_Ball_body_entered(body):
	if !can_sleep:
		if body != last_hit:
			emit_signal("ball_hit", body.name)
			last_hit = body

