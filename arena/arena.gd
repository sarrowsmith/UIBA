extends Node2D


signal score(score)

onready var launcher = $Launcher
onready var bottom = $BottomBox
onready var bonus_label = $"BonusPin/Label"
onready var bonus_pin = $"BonusPin/Area2D"

var bottom_pocket = 0
var score_pocket = 0
var can_launch = false
var score_multiplier = 0
var multiplier_label


func _ready():
	bonus_pin.connect("body_entered", self, "_on_BonusPin_body_entered")


func new_game(game_name, multiplier):
	bonus_label = game_name[1]
	multiplier_label = multiplier
	score_multiplier = 0
	inc_multiplier()
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
		emit_signal("score", score * (score_multiplier))


func _on_OutOfBounds_body_entered(body):
	body.queue_free()
	launcher.new_ball()


func inc_multiplier():
	if multiplier_label == null:
		return
	score_multiplier += 1
	multiplier_label.text = "x%d" % score_multiplier


func _on_BonusPin_body_entered(_body):
	inc_multiplier()
