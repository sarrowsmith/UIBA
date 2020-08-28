extends Node2D


signal ball_launched

export (PackedScene) var Ball
export var reset = 1.0
export var impulse = 0.0
export(Array, String) var hit_names
export(Array, AudioStream) var hit_sounds
export(AudioStream) var launch_sound

onready var reset_timer = $ResetTimer
onready var open_port = $Open
onready var audio = $AudioStreamPlayer

var ball
var balls = []
enum { LAUNCHED, CAN_RESET, WAIT, CAN_LAUNCH }
var state
var sound_map = {}


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		launch_ball()


func new_game():
	state = CAN_RESET
	for b in balls:
		b.queue_free()
	balls = []
	new_ball()


func new_ball():
	if state == CAN_RESET:
		open_port.visible = true
		if ball != null:
			ball.disconnect("ball_hit", self, "_on_Ball_ball_hit")
		reset_timer.start(reset)


func launch_ball():
	if state == CAN_LAUNCH:
		state = LAUNCHED
		reset_timer.start(reset)
		ball.apply_central_impulse(Vector2(0, -30) * impulse)
		audio.stream = launch_sound
		audio.play()
		emit_signal("ball_launched")


func _on_ResetTimer_timeout():
	if state == CAN_RESET:
		ball = Ball.instance()
		add_child(ball)
		ball.connect("ball_hit", self, "_on_Ball_ball_hit")
		balls.append(ball)
		reset_timer.start(reset)
	else:
		open_port.visible = false
	state += 1


func _on_StartButton_pressed():
	launch_ball()


func _on_Ball_ball_hit(hit):
	if audio.playing:
		return
	if not sound_map.has(hit):
		var idx = hit_names.find(hit)
		sound_map[hit] = hit_sounds[idx] # -1 is valid!
	var sound = sound_map.get(hit)
	if sound != null:
		audio.stream = sound
		audio.play()
