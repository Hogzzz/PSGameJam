extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -350.0
const WALL_SLIDE_MAX_SPEED = 4
var enemy_inattack_range = false
var enemy_cooldown = true
var health = 100
var player_alive = true
var amount_of_jumps = 1
var is_wall_sliding = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var playerref = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var death = $Death
@onready var jump_timer = $"Jump Timer"


func _physics_process(delta):
	jump()
	# Death Action
	if health <=0:
		player_alive = false
		print("You Died!")
		Engine.time_scale = 0.5
		health = 100
		playerref.get_node("CollisionShape2D").queue_free()
		death.start()

	# Add the gravity.
	if is_on_floor():
		velocity.y += gravity * delta
	elif !is_on_floor():
		velocity.y += gravity * delta
	elif is_on_wall() and !is_on_floor():
		velocity.y = WALL_SLIDE_MAX_SPEED
	
	

	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	#elif Input.is_action_just_pressed("jump") and 

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play anmiations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
			animated_sprite.play("Jump")

	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() :
			if amount_of_jumps == 0:
				amount_of_jumps = 1
			velocity.y = JUMP_VELOCITY
			print(amount_of_jumps)
		elif !is_on_floor() and amount_of_jumps > 0:
			velocity.y = JUMP_VELOCITY
			amount_of_jumps -= 1
			print(amount_of_jumps)
		elif is_on_wall() and amount_of_jumps > 0:
			velocity.y = JUMP_VELOCITY
			amount_of_jumps -= 1
