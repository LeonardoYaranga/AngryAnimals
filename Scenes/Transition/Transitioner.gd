extends CanvasLayer
class_name Transitioner

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_anim() -> void:
	animation_player.play("fade")

func change_scene() -> void:
	GameManager.change_to_next_scene()
