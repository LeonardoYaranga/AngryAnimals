extends Node

@onready var start: Marker2D = $Start
const ANIMAL = preload("uid://hry4tlce2bq2")

func _ready() -> void:
	spawn_animal()
	SignalHub.on_animal_died.connect(spawn_animal)

func spawn_animal() -> void:
	var animal: Animal = ANIMAL.instantiate() as Animal
	animal.global_position = start.global_position
	call_deferred("add_child", animal)
