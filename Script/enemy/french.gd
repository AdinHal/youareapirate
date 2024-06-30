extends CharacterBody2D 

@onready var sprite_2d = $Sprite2D 
@onready var kick_area = $Kick

@export var speed: float = 30.0
@export var move_distance: float = 30.0

var moving_left = true
var start_position: float
var is_attacking = false

func _ready():
	start_position = position.x
	sprite_2d.play("walking")

func _physics_process(delta):
	if moving_left:
		velocity.x = -speed
		if position.x <= start_position - move_distance:
			moving_left = false
			sprite_2d.flip_h = false
	else:
		velocity.x = speed
		if position.x >= start_position + move_distance:
			moving_left = true
			sprite_2d.flip_h = true

	move_and_slide()
	
	if sprite_2d.animation == "attack" and is_attacking == true:
		match sprite_2d.frame:
			4: 
				turn_on_monitoring()
			9:  
				turn_off_monitoring()


func counterattack():
	sprite_2d.animation = "attack"
	is_attacking = true
	var main_character = get_node_or_null("MainCharacter")
	if main_character:
		main_character.take_damage(5)

func play_dying_animation():
	sprite_2d.animation = "dying"
	sprite_2d.connect("animation_finished", Callable(self, "_on_dying_animation_finished"))

func _on_dying_animation_finished():
	queue_free()

func turn_on_monitoring():
	kick_area.monitoring = true

func turn_off_monitoring():
	kick_area.monitoring = false
