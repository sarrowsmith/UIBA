extends CanvasLayer


signal start_game


onready var panel = $Control
onready var message = $"Control/Message"
onready var message_timer = $MessageTimer
onready var start_button = $StartButton

export(String, MULTILINE) var intro_text
export(String, MULTILINE) var instructions


func _ready():
	show_start(intro_text)


func show_message(text):
	message.text = text
	message.show()
	message_timer.start()


func show_game_over(game_name, score):
	panel.show()
	show_message("Game Over\n\n%04d" % score)
	# Wait until the message_timer has counted down.
	yield(message_timer, "timeout")
	show_start(game_name)


func show_start(game_name):
	message.text = game_name
	message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	start_button.show()


func _on_MessageTimer_timeout():
	message.hide()


func _on_StartButton_pressed():
	start_button.hide()
	show_message(instructions)
	emit_signal("start_game")
	yield(message_timer, "timeout")
	panel.hide()
