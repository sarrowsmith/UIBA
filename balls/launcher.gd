extends Node2D


signal ball_launched

export (PackedScene) var Ball
export var reset = 1.0
export var impulse = 0.0

onready var reset_timer = $ResetTimer
onready var open_port = $Open

var ball
var balls = []
var state
enum { LAUNCHED, CAN_RESET, WAIT, CAN_LAUNCH }


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
		reset_timer.start(reset)


func launch_ball():
	if state == CAN_LAUNCH:
		state = LAUNCHED
		reset_timer.start(reset)
		ball.apply_central_impulse(Vector2(0, -30) * impulse)
		emit_signal("ball_launched")


func _on_ResetTimer_timeout():
	if state == CAN_RESET:
		ball = Ball.instance()
		add_child(ball)
		balls.append(ball)
		reset_timer.start(reset)
	else:
		open_port.visible = false
	state += 1


func _on_StartButton_pressed():
	launch_ball()

