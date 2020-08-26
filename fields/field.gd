extends Node2D


export(Array, PackedScene) var components
export(bool) var canAnimate

const AnimatedComponent = preload("component.gd")


func _ready():
	var component = components[randi() % len(components)].instance()
	add_child(component)
	if component is AnimatedComponent &&\
		component.animationType == AnimatedComponent.Type.EXTERNAL &&\
		canAnimate && randf() * 3 < 1:
			var animationPlayer = get_node("AnimationPlayer")
			var animations = animationPlayer.get_animation_list()
			animationPlayer.play(animations[randi() % len(animations)])
