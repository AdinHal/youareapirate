extends CanvasLayer

var coinCount = 0
@export var healthCount : int = 95

func _ready():
	$Coins.text = str(coinCount)
	updateHealthDisplay()

func updateHealthDisplay():
	$Health.text = ""
	$Health.text = str(healthCount)

func setHealthCount(amount:int):
	healthCount = amount
	$Health.text = str(healthCount)

func _on_rum_body_entered(body):
	if healthCount < 100:
		healthCount += 5
		if healthCount > 100:
			healthCount = 100
		updateHealthDisplay()

func _on_coins_body_entered(body):
	coinCount += 2
	$Coins.text = str(coinCount)
	
	if coinCount >= 70:
		display_win_screen()

func display_win_screen():
	get_tree().call_deferred("change_scene_to_file","res://scenes/you_won.tscn")


func _on_chest_body_entered(body):
	coinCount += 10
	$Coins.text = str(coinCount)
	
	if coinCount >= 70:
		display_win_screen()
