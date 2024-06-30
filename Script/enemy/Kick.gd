extends Area2D

@export var damage : int = 5

func _ready():
	monitoring = false


func _on_body_entered(body):
	if body is CharacterBody2D:
		for child in body.get_children():
			if child is MainCharacterDamage:
				child.hit(damage)
