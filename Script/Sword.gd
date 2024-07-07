extends Area2D

@export var damage : int = 20

func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage-5)
			#print_debug(body.name + " took "+str(damage)+".")
		elif child is Damage:
			child.hit(damage)
			#print_debug(body.name + " took "+str(damage)+".")
		elif child is BritishDamage:
			child.hit(damage-10)
			#print_debug(body.name + " took "+str(damage)+".")
