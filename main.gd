extends Node2D


export var next = 1.5
export var balls = 10
onready var total = 0
onready var left = balls
onready var arena = $Arena
onready var timeout = $Timer
onready var scoreBox = $"ScoreBox/Score"
onready var ballsLeft = $"ScoreBox/Balls"


func _init():
	randomize()


func _ready():
	scored(0)
	new_ball()


func new_ball():
	if arena.new_ball():
		left -= 1
		ballsLeft.text = "%d" % left


func scored(value):
	total += value
	scoreBox.text = "%04d" % total


func _on_Arena_score(score):
	scored(score)
	timeout.start(next)


func _on_Timer_timeout():
	if left == 0:
		print("GameOver")
	else:
		new_ball()
