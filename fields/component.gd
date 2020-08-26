extends Node2D


enum Type { NONE, SELF, EXTERNAL }
export(Type) var animationType


func _ready():
	if animationType == Type.SELF:
		var animationPlayer = $AnimationPlayer
		var animations = animationPlayer.get_animation_list()
		animationPlayer.play(animations[randi() % len(animations)])
