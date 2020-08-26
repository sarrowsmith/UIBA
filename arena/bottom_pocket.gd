extends Node2D


signal scored(identifier, score)

export var identifier = 0

onready var label = $Label
var score



func _ready():
	score = ( 5 + (randi() % 20 )) * (4 - abs(identifier - 4))
	label.text = "%d" % score


func _on_Pocket_body_entered(body):
	emit_signal("scored", identifier, score)
	if body is RigidBody2D:
		body.can_sleep = true
