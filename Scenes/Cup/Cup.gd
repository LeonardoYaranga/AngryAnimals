class_name Cup

extends StaticBody2D

const GROUP_NAME: String = "Cup"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	
func die() -> void:
	animation_player.play("vanish")
	await animation_player.animation_finished
	SignalHub.emit_on_cup_destroyed()
	queue_free()

#Other way to manage the behavior with specific animations
#func _on_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "vanish" : queue_free()
