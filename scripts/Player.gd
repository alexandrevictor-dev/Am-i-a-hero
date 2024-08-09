extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 110.0
const JUMP_VELOCITY = -230.0
var MAX_JUMP = 2
var jump_count = 0
var gravity_multiplier = 1.0 #Quero adicionar para fazer o pulo ser mais pesado na descida,
var GRAVITY_MAX = 300 #limite na queda pra não descer igual a um cometa
var interact = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta 
	else:
		jump_count = 0
		
	if velocity.y > GRAVITY_MAX:
		velocity.y = GRAVITY_MAX

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (jump_count < MAX_JUMP):
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	# Get the input direction 
	var direction = Input.get_axis("move_left", "move_right")
	
		
	#Flip sprites
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Change sprites
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		if velocity.y <0:
			animated_sprite.play("Jump")
		elif velocity.y >150:
			animated_sprite.play("fall")
		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
