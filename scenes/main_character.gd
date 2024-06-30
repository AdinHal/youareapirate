extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite_2d = $Sprite2D
@onready var sword_area = $Sword
@onready var hud = get_parent().get_node("HUD")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var starting_position = Vector2(317, 433)
var is_attacking = false

@export var health: int

func _ready():
	if hud:
		health = hud.healthCount 

func _physics_process(delta):
	if position.y > 1000:
		reset_position()

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if sprite_2d.animation == "attack" and is_attacking == true:
		match sprite_2d.frame:
			3: 
				turn_on_monitoring()
			5:  
				turn_off_monitoring()

	if Input.is_action_pressed("ui_attack"):
		sprite_2d.animation = "attack"
		is_attacking = true
	else:
		if not is_on_floor():
			sprite_2d.animation = "jump"
			is_attacking = false
		elif abs(velocity.x) > 1:
			sprite_2d.animation = "walk"
			is_attacking = false
		else:
			sprite_2d.animation = "default"
			is_attacking = false
	
	sprite_2d.flip_h = velocity.x < 0

func reset_position():
	position = starting_position
	velocity = Vector2()

func turn_on_monitoring():
	sword_area.monitoring = true
	#print("Monitoring sword is turned on.")

func turn_off_monitoring():
	sword_area.monitoring = false
	#print("Monitoring sword is turned off.")
	

func counterattack():
	sprite_2d.animation = "attack"
	is_attacking = true

func take_damage(amount: int):
	health -= amount
	print("Health:", health)
	hud.setHealthCount(health)
	if health <= 0:
		sprite_2d.animation = "die"
		sprite_2d.play("die")
		sprite_2d.connect("animation_finished", Callable(self, "die"))
		die()

func die():
	sprite_2d.disconnect("animation_finished", Callable(self, "die"))
	get_tree().change_scene_to_file("res://scenes/UI/you_died.tscn")
	queue_free()
