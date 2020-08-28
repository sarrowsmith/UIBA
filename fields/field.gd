extends Node2D


export(Array, PackedScene) var components
export(bool) var can_animate

const AnimatedComponent = preload("component.gd")


func _ready():
	var component = components[randi() % len(components)].instance()
	add_child(component)
	if component is AnimatedComponent &&\
		component.animation_type == AnimatedComponent.Type.EXTERNAL &&\
		can_animate && randf() * 3 < 1:
			var animationPlayer = get_node("AnimationPlayer")
			var animations = animationPlayer.get_animation_list()
			animationPlayer.play(animations[randi() % len(animations)])
