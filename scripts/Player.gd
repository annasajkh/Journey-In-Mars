extends KinematicBody2D

onready var animation : AnimationPlayer = $AnimationPlayer
onready var sprite : Sprite = $Sprite
onready var gun_sprite : Sprite = $Gun
onready var health_bar : ProgressBar = $HealthBar


var velocity : Vector2
var speed : float = 10
var friction : float = 0.3
var gravity : float = 15
var jump_height : float = 200
var MAX_SPEED : float = 300
var MAX_GRAVITY : float = 500
var health : float = 100

func _ready():
	Global.camera = $Camera2D

func get_input() -> void:
	if Input.is_key_pressed(KEY_D):
		velocity.x += speed
		animation.play("walk")
		sprite.flip_h = false
	elif Input.is_key_pressed(KEY_A):
		velocity.x -= speed
		animation.play("walk")
		sprite.flip_h = true
	else:
		animation.play("idle")
		velocity.x -= velocity.x * friction
	
	if Input.is_key_pressed(KEY_SPACE) && is_on_floor():
		$PlayerJump.play()
		velocity.y = -jump_height

func hit(damage : float) -> void:
	var hit_anim : AnimationPlayer = $HitAnimation
	if !hit_anim.is_playing():
		$PlayerHit.play()
		health -= damage
		hit_anim.play("hit")


func _physics_process(delta : float) -> void:
	if !Global.end:
		health_bar.value = health
		if health <= 0 && !$DieAnimation.is_playing():
			$DieAnimation.play("die")
		gun_sprite.look_at(get_global_mouse_position())
		
		if gun_sprite.rotation_degrees > 360 ||gun_sprite.rotation_degrees < -360:
			gun_sprite.rotation_degrees = 0
		
		if gun_sprite.rotation_degrees > 90 || gun_sprite.rotation_degrees < -90:
			gun_sprite.flip_v  = true
		else:
			gun_sprite.flip_v = false
		
		get_input()
		
		velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
		velocity.y += gravity
		velocity.y = clamp(velocity.y, -MAX_GRAVITY,MAX_GRAVITY)
		velocity = move_and_slide(velocity,Vector2.UP)

func pause():
	get_tree().paused = true

func resume():
	get_tree().paused = false

func reload():
	get_tree().reload_current_scene()
