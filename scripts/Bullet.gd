extends Area2D

var velocity : Vector2
var explode : bool = false

func _process(delta):
	if !explode:
		position += velocity * delta


func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.health -= Global.player_damage
	explode = true
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("explode")


func _on_ExplodeTimer_timeout():
	$AnimationPlayer.play("explode")
