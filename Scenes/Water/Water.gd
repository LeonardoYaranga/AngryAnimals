extends Area2D

@onready var splash_sound_2d: AudioStreamPlayer2D = $SplashSound2D

func _on_body_entered(body: Node2D) -> void:
	if body is Animal:
		splash_sound_2d.global_position = body.global_position
		print("splash_sound_2d.get_playback_position()",splash_sound_2d.get_playback_position())
		splash_sound_2d.play()
		body.die()
