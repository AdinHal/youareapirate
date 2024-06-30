extends Control

var audio_player: AudioStreamPlayer

func _ready():
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = load("res://resources/audio/DrunkenSailor - Instrumental Fiddle Sea Shanty_free.mp3") 
	add_child(audio_player)
	audio_player.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/loading.tscn")
	pass


func _on_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options.tscn")
	pass # Replace with function body.
