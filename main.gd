extends Node2D


export(AudioStream) var score_sound
export(AudioStream) var game_over_sound
export var next = 1.5
export var balls = 10

onready var total = 0
onready var left = balls
onready var arena = $Arena
onready var timeout = $Timer
onready var score_box = $"ScoreBox/Score"
onready var balls_left = $"ScoreBox/Balls"
onready var ui = $Screen
onready var audio = $AudioStreamPlayer

var game_name


func _init():
	randomize()
	game_name = "New Game"
	seed(game_name.hash())


func new_game():
	scored(0)
	arena.new_game(game_name)


func new_ball():
	if arena.new_ball():
		left -= 1
		balls_left.text = str(left)


func scored(value):
	total += value
	score_box.text = "%04d" % total
	audio.stream = score_sound
	audio.play()



func _on_Arena_score(score):
	scored(score)
	timeout.start(next)


func _on_Timer_timeout():
	if left == 0:
		ui.show_game_over(game_name, total)
		audio.stream = game_over_sound
		audio.play()
	else:
		new_ball()


func _on_HUD_start_game():
	new_game()
