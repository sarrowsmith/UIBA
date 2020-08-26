extends Node2D


signal bottom_score(pocket_number, score)


func _on_BottomPocket_scored(pocket_number, score):
	emit_signal("bottom_score", pocket_number, score)
