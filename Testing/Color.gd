extends ColorRect

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("drag"):
		print("%s _physics_process" % name)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input" % name)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _unhandled_input" % name)
	# if name == "Green":
	# 	get_viewport().set_input_as_handled()

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _gui_input" % name)
