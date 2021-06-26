extends StaticBody2D

var body : KinematicBody2D
var detected : bool = false
var body_damage : KinematicBody2D
var detected_mouth : bool = false
var sucking_speed : float = 10

func _process(delta):
	if detected_mouth:
		body_damage.hit(25)
	if detected:
		body.velocity.x += sucking_speed


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Sprite.visible = false
		$notplant.visible = true
		self.body = body
		detected = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$Sprite.visible = true
		$notplant.visible = false
		self.body = null
		detected = false


func _on_Mouth_body_entered(body):
	if body.name == "Player":
		detected_mouth = true
		body_damage = body


func _on_Mouth_body_exited(body):
	if body.name == "Player":
		detected_mouth = false
		body_damage = null
