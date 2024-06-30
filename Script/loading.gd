extends Control


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	# $ProgressBar.value+=1
	$TextureProgressBar.value+=2
	if $TextureProgressBar.value >= 100.0:
		get_tree().change_scene_to_file("res://youareapiratemain.tscn")
	pass # Replace with function body.


	
