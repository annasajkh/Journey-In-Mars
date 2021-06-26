extends Node2D

onready var bullet : PackedScene = preload("res://scenes/Bullet.tscn")
onready var player : KinematicBody2D  = $Player
onready var gun : Sprite  = $Player/Gun
onready var ray : RayCast2D = $Player/RayCast2D
onready var rocket : Area2D = $Area2D

func _process(delta):
	if Global.end:
		player.position = rocket.position
	var mouse_pos : Vector2 = get_global_mouse_position()
	ray.position = gun.get_global_transform().get_origin().direction_to(mouse_pos) * 9
	ray.cast_to = ray.get_global_transform().get_origin().direction_to(mouse_pos) * 10


func _on_ShootTimer_timeout():
	if Input.is_mouse_button_pressed(1):
		$Player/PlayerShoot.play()
		var b = bullet.instance()
		b.position = ray.get_global_transform().get_origin()
		b.velocity = b.position.direction_to(get_global_mouse_position()) * 300
		player.velocity -= b.velocity * 0.1
		add_child(b)
		


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Global.end = true
		$End.play("end")

func change_scene_to_end():
	get_tree().change_scene("res://scenes/End.tscn")
