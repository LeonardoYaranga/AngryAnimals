class_name Animal

extends RigidBody2D

@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound

@export var DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
@export var DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)
@export var IMPULSE_MULT: float = 10.0
var impulse_max: float = 800


var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _is_dragging: bool = false
var _arrow_scale_x: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag"):
		call_deferred("start_release")

func _ready() -> void:
	_start = position
	_arrow_scale_x = arrow.scale.x

func _process(delta: float) -> void:
	var debug_string: String = ""
	debug_string = "Freeze:%s\n Sleeping: %s\n Contacts Reported: %s\n" % [
		freeze, is_sleeping(), str(get_contact_count())]
	debug_string += "is_dragging %s\n drag_start: %s\n" % [_is_dragging, _drag_start]
	debug_string += "dragged_vector: %s\n" % _dragged_vector
	debug_string += "impulse: %s\n" % calculate_impulse()
	debug_string += "impulse length: %s\n" % calculate_impulse().length()
	label.text = debug_string
	
func _physics_process(delta: float) -> void:
	if _is_dragging and Input.is_action_pressed("drag"):
		hadle_dragging()
	
func start_release() -> void:
	launch_sound.play()
	freeze = false
	_is_dragging = false
	apply_central_impulse(calculate_impulse())
	arrow.hide()

func calculate_impulse() -> Vector2:
	return _dragged_vector * IMPULSE_MULT * -1

func hadle_dragging() -> void:
	var new_dragged_vector: Vector2 = get_global_mouse_position() - _drag_start
	new_dragged_vector = new_dragged_vector.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)

	var diff: Vector2 = new_dragged_vector - _dragged_vector
	print("Diff length: %s" % diff.length())
	if diff.length() > 0 && !stretch_sound.playing:
		stretch_sound.play()

	scale_arrow()
	_dragged_vector = new_dragged_vector
	position = _start + _dragged_vector
	
	
func scale_arrow() -> void:
	var imp_len: float = calculate_impulse().length()
	var perc: float = clamp(imp_len / impulse_max, 0.0, 1.0)
	arrow.scale.x = lerpf(_arrow_scale_x, _arrow_scale_x * 2, perc)
	arrow.rotation = (_start - position).angle()
	# arrow.rotation = _dragged_vector.angle() - PI
	# arrow.scale.x = _dragged_vector.length() / arrow.texture.get_size().x

func start_dragging() -> void:
	_is_dragging = true
	_drag_start = get_global_mouse_position()
	arrow.show()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		input_event.disconnect(_on_input_event)
		start_dragging()
