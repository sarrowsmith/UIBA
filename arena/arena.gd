extends Node2D


signal score(score)

onready var launcher = $Launcher
onready var bottom = $BottomBox

var bottom_pocket = 0
var score_pocket = 0
var can_launch = false


func new_ball():
	if bottom_pocket == 0:
		bottom_pocket = score_pocket
		launcher.new_ball()
		can_launch = false
	return !can_launch


func _on_Launcher_ball_launched():
	bottom_pocket = 0


func _on_BottomBox_bottom_score(pocket_number, score):
	if pocket_number != bottom_pocket:
		can_launch = true
		score_pocket = pocket_number
		emit_signal("score", score)


func _on_OutOfBounds_body_entered(body):
	body.queue_free()
	launcher.new_ball()
