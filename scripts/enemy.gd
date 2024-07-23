extends CharacterBody2D
@onready var global = $"../Global"
const SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var health = 100
var player_inattack_zone = false

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta
	deal_with_damage()
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
func enemy():
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_curent_attack == true:
		health = health - 50
		print("slime health = ", health)
		if health <= 0:
			self.queue_free()
