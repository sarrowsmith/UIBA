extends Node2D


const Utils = preload("res://utils.gd")

enum Type { NONE, SELF, EXTERNAL }
export(Type) var animation_type


func _ready():
	if animation_type == Type.SELF:
		var animationPlayer = $AnimationPlayer
		animationPlayer.play(Utils.pick(animationPlayer.get_animation_list()))
