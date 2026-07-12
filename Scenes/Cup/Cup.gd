
class_name Cup

extends StaticBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

	
func die() -> void:
	animation_player.play("vanish")
	await animation_player.animation_finished
	queue_free()

#Other way to manage the behavior with specific animations
#func _on_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "vanish" : queue_free()
