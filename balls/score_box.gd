extends Control


onready var master_index = AudioServer.get_bus_index("Master")


func _on_CheckBox_toggled(button_pressed):
	AudioServer.set_bus_mute(master_index, !button_pressed)
