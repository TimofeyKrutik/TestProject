extends CharacterBody2D

enum {
	IDLE,
	MOVE,
	ATTACK,
	ATTACK2,
	ATTACK3,
	BLOCK,
	SLIDE,
}
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
var health = 100
var gold = 0
var state = MOVE
var run_speed = 1
var combo = false
var attack_cooldown = false

func _physics_process(delta):
	match state:
		MOVE:
			move_state()
		#ATTACK:
			#attack_state()
		#ATTACK2:
			#attack2_state()
		#ATTACK3:
			#attack3_state()
		#BLOCK:
			#block_state()
		#SLIDE:
			#slide_state()
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if velocity.y > 0:
		anim.play("Fall")
	
	if health <= 0:
		health = 0
		#animPlayer.play("Death")
		#await animPlayer.animation_finished
		queue_free()
		get_tree().change_scene_to_file("res://menu.tscn")
	
	move_and_slide()
	
func move_state ():
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED * run_speed
		if velocity.y == 0:
			if run_speed == 1:
				$AnimatedSprite2D.play("Walk")
			else:
				$AnimatedSprite2D.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if direction == -1:
		anim.flip_h = true
		
	elif direction == 1:
		anim.flip_h = false
	if Input.is_action_just_pressed("run"):
		run_speed = 2
	else:
		run_speed = 1
	
	
	
	
	
	move_and_slide()
