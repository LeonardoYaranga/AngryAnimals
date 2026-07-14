extends Area2D

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("drag"):
		print("%s _physics_process" % name)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input" % name)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _unhandled_input" % name)
		
func _unhandled_key_input(event: InputEvent) -> void:
	print("%s _unhandled_key_input %s" % [name, event.as_text()])

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input_event" % name)
