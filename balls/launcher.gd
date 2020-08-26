extends Node2D


signal ball_launched

export (PackedScene) var Ball
export var reset = 2.0
export var impulse = 0.0

onready var resetTimer = $ResetTimer
onready var closedPort = $Closed
onready var openPort = $Open

var ball
var state
enum { LAUNCHED, CAN_RESET, WAIT, CAN_LAUNCH }

func _ready():
	state = CAN_RESET


func _process(_delta):
	if state == CAN_LAUNCH && Input.is_action_just_pressed("ui_accept"):
		launch_ball()


func new_ball():
	if state == CAN_RESET:
		openPort.visible = true
		resetTimer.start(reset)


func launch_ball():
	state = LAUNCHED
	resetTimer.start(reset)
	ball.apply_central_impulse(Vector2(0, -30) * impulse)
	emit_signal("ball_launched")


func _on_ResetTimer_timeout():
	if state == CAN_RESET:
		ball = Ball.instance()
		add_child(ball)
		resetTimer.start(reset)
	else:
		openPort.visible = false
	state += 1
