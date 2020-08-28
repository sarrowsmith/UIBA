extends CanvasLayer


signal start_game


onready var panel = $Control
onready var message = $"Control/Message"
onready var message_timer = $MessageTimer
onready var start_button = $StartButton

export(String, MULTILINE) var game_name


func _ready():
	show_start()


func show_message(text):
	message.text = text
	message.show()
	message_timer.start()


func show_game_over():
	panel.show()
	show_message("Game Over")
	# Wait until the message_timer has counted down.
	yield(message_timer, "timeout")
	show_start()


func show_start():
	message.text = game_name
	message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	start_button.show()


func _on_MessageTimer_timeout():
	message.hide()


func _on_StartButton_pressed():
	start_button.hide()
	panel.hide()
	emit_signal("start_game")
