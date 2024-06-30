extends Node

class_name BritishDamage

@export var health: float = 100:
	get:
		return health
	set(value):
		SignalBb.emit_signal("on_health_change", get_parent(), value-health)
		health = value

func hit(damage: int):
	health -= damage

	var parent = get_parent()
	if health <= 0:
		if parent.has_method("british_play_dying_animation"):
			parent.british_play_dying_animation()
	elif parent.has_method("counterattack"):
		parent.counterattack()
