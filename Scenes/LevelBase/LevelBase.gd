extends Node

@onready var start: Marker2D = $Start
const ANIMAL = preload("uid://hry4tlce2bq2")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal()
	SignalHub.animal_died.connect(spawn_animal)

func spawn_animal() -> void:
	var animal: Animal = ANIMAL.instantiate() as Animal
	animal.global_position = start.global_position
	call_deferred("add_child", animal)
