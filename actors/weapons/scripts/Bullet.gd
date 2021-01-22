extends RigidBody2D

signal on_target_hit(body)

func _on_Bullet_body_entered(body):
	if body.is_in_group("Enemies"):
		emit_signal("on_target_hit",body)
	queue_free()
