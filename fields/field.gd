extends Node2D


const Utils = preload("res://utils.gd")
const AnimatedComponent = preload("component.gd")

export(Array, PackedScene) var components
export(bool) var can_animate


func _ready():
	var component = Utils.pick(components).instance()
	add_child(component)
	if component is AnimatedComponent &&\
		component.animation_type == AnimatedComponent.Type.EXTERNAL &&\
		can_animate && randf() * 3 < 1:
			var animationPlayer = get_node("AnimationPlayer")
			animationPlayer.play(Utils.pick(animationPlayer.get_animation_list()))
