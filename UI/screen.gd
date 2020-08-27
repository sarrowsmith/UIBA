extends CanvasLayer


signal start_game


onready var panel = $Control
onready var message = $"Control/Message"
onready var messageTimer = $MessageTimer
onready var startButton = $StartButton

export(String, MULTILINE) var gameName


func _ready():
	show_start()


func show_message(text):
	message.text = text
	message.show()
	messageTimer.start()


func show_game_over():
	panel.show()
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield(messageTimer, "timeout")
	show_start()


func show_start():
	message.text = gameName
	message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	startButton.show()


func _on_MessageTimer_timeout():
	message.hide()


func _on_StartButton_pressed():
	startButton.hide()
	panel.hide()
	emit_signal("start_game")
