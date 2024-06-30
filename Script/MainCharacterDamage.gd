extends Node

class_name MainCharacterDamage

@export var health: float = 100:
	get:
		return health
	set(value):
		SignalBb.emit_signal("on_health_change", get_parent(), value-health)
		health = value

func hit(damage: int):

	var parent = get_parent()
	
	if parent.has_method("take_damage"):
			parent.take_damage(damage)
	elif parent.has_method("counterattack"):
		parent.counterattack()
