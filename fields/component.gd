extends Node2D


enum Type { NONE, SELF, EXTERNAL }
export(Type) var animation_type


func _ready():
	if animation_type == Type.SELF:
		var animationPlayer = $AnimationPlayer
		var animations = animationPlayer.get_animation_list()
		animationPlayer.play(animations[randi() % len(animations)])
