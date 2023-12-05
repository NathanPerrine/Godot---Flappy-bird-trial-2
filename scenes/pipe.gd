extends Area2D

signal hit
signal scored

func _on_body_entered(body):
	if body.name == "Bird":
		hit.emit()

func _on_score_area_body_entered(body):
	if body.name == "Bird":
		scored.emit()
