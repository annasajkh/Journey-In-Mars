extends Node2D


func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://scenes/World.tscn")
