extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var enemy_inattack_range = false
var enemy_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var playerref = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var death = $Death
@onready var global = $"../Global"


func _physics_process(delta):
	enemy_attack()
	attack()
	# Death Actions
	if health <=0:
		player_alive = false
		print("You Died!")
		Engine.time_scale = 0.5
		health = 100
		playerref.get_node("CollisionShape2D").queue_free()
		death.start()

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
			if attack_ip == false:
				animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
		if velocity.y > 0:
			animated_sprite.play("Fall")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func player():
	pass


func enemy_attack():
	if enemy_inattack_range and enemy_cooldown == true:
		health = health - 20
		enemy_cooldown = false
		$"Attack Cooldown".start()
		print("ouch")

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		



func _on_attack_cooldown_timeout():
	enemy_cooldown = true
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func attack():
	if Input.is_action_just_pressed("Attack"):
		global.player_current_attack = true
		attack_ip = true
		animated_sprite.play("Attack")
		$deal_attack_timer.start()


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
