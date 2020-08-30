extends Node2D


signal score(score)

onready var launcher = $Launcher
onready var bottom = $BottomBox
onready var bonus_label = $"BonusPin/Label"
onready var bonus_pin = $"BonusPin/Area2D"
onready var audio = $AudioStreamPlayer

var bottom_pocket = 0
var score_pocket = 0
var can_launch = false
var score_multiplier = 0
var multiplier_label
var game_identifier = ""

func _ready():
	bonus_pin.connect("body_entered", self, "_on_BonusPin_body_entered")


func new_game(game_name, multiplier):
	game_identifier = game_name
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


func flash_score(value):
	bonus_label.text = value
	yield(get_tree().create_timer(1), "timeout")
	bonus_label.text = game_identifier


func inc_multiplier():
	if multiplier_label == null:
		return
	audio.play()
	score_multiplier += 1
	multiplier_label.text = "x%d" % score_multiplier
	flash_score("*%d" % score_multiplier)


func _on_Launcher_ball_launched():
	bottom_pocket = 0


func _on_BottomBox_bottom_score(pocket_number, score):
	if pocket_number != bottom_pocket:
		can_launch = true
		score_pocket = pocket_number
		var scored = score * score_multiplier
		flash_score(str(scored))
		emit_signal("score", scored)


func _on_OutOfBounds_body_entered(body):
	body.queue_free()
	launcher.new_ball()


func _on_BonusPin_body_entered(_body):
	inc_multiplier()
