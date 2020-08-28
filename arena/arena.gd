extends Node2D


signal score(score)

onready var launcher = $Launcher
onready var bottom = $BottomBox
onready var bonus_label = $"BonusPin/Label"

var bottom_pocket = 0
var score_pocket = 0
var can_launch = false
var score_multiplier = 0


func new_game():
	score_multiplier = 0
	bonus_label.text = str(score_multiplier)
	score_pocket = 0
	can_launch = true
	launcher.new_game()


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
		emit_signal("score", score * (1 + score_multiplier))


func _on_OutOfBounds_body_entered(body):
	body.queue_free()
	launcher.new_ball()


func _on_BonusPin_body_entered(_body):
	score_multiplier += 1
	bonus_label.text = str(score_multiplier)
