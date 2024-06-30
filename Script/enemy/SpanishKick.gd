extends Area2D

@export var damage : int = 10

func _ready():
	monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	


func _on_body_entered(body):
	if body is CharacterBody2D:
		for child in body.get_children():
			if child is MainCharacterDamage:
				child.hit(damage)
