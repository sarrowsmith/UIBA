extends RigidBody2D


export(String) var hit_names
export(Array) var hit_sounds

var sound_map

func _ready():
	pass


func _on_Timer_timeout():
	if not sleeping:
		apply_central_impulse(Vector2(rand_range(-100, +100), rand_range(-100, +100)))


func _on_Ball_body_entered(body):
	if !can_sleep:
		print(body.name)

