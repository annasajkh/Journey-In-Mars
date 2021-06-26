extends KinematicBody2D

var body : KinematicBody2D
var body2 : KinematicBody2D
var body_detected : bool = false
var body_in : bool = false
var velocity : Vector2
var MAX_SPEED : float = 100
var speed : float = 10
var explode : bool = false
var health : float = 200
var stop_shake : bool = false
var damage : float = 20

func _physics_process(delta):
	if body_detected:
		velocity.x += (1 if body2.position.x - position.x > 0 else -1) * speed
		velocity.y += (1 if body2.position.y - 30 - position.y > 0 else -1) * speed
	
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)
	
	rotation_degrees = range_lerp(velocity.x,-100,100,-45,45)
	
	if body_in:
		body.hit(damage)
	if health <= 0:
		$Area2D/CollisionPolygon2D.disabled  = true
		$Noise.stop()
		explode = true
		$AnimationPlayer.play("explode")
	if !explode:
		move_and_slide(velocity)
	elif explode && !stop_shake:
		Global.camera.offset = Vector2(rand_range(-3,3),rand_range(-3,3))

func change_cam_offset_back():
	stop_shake = true
	Global.camera.offset = Vector2.ZERO

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body_in = true
		self.body = body

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body_in = false
		self.body = null


func _on_DetectArea_body_entered(body):
	if body.name == "Player":
		$Noise.play()
		body_detected = true
		self.body2 = body


func _on_DetectArea_body_exited(body):
	if body.name == "Player":
		$Noise.stop()
		body_detected = false
		self.body2 = null
