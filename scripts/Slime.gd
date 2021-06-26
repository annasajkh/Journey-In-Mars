extends KinematicBody2D

var velocity : Vector2
var gravity : float = 10
var jump_height : float = 100
var health : float = 25
var body_in : bool = false
var speed : float = 50
var body : KinematicBody2D

func _physics_process(delta):
	if health <= 0:
		$AnimationPlayer.play("die")
	else:
		if is_on_wall():
			velocity.y = -jump_height
		if body_in:
			velocity.x = speed if body.position.x > position.x else -speed
		else:
			velocity.x = 0
		
		
		velocity.y += gravity
		velocity = move_and_slide(velocity,Vector2.UP)

func _on_View_body_entered(body):
	if body.name == "Player":
		body_in  = true
		self.body = body

func _on_View_body_exited(body):
	if body.name == "Player":
		body_in  = false
		self.body = null
