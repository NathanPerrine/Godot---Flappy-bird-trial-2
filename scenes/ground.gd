extends Area2D

signal hit

func _on_body_entered(body):
	print(body.name)
	if body.name == "Bird":
		hit.emit()
