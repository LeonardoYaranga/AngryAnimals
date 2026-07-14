extends TextureButton
@export var level_number: int = 0
@onready var level_number_label: Label = $MarginContainer/VB/LevelNumberLabel

func _ready() -> void:
	level_number_label.text = str(level_number)

func _on_mouse_entered() -> void:
	set_scale(Vector2(1.1, 1.1))

func _on_mouse_exited() -> void:
	set_scale(Vector2(1, 1))


func _on_pressed() -> void:
	GameManager.change_to_level_scene(level_number)
