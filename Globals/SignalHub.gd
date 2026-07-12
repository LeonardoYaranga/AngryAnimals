extends Node

signal animal_died

func emit_animal_died() -> void:
	animal_died.emit()
