class_name GameUi

extends Control

var _total_cups: int = 0
var _current_cups: int = 0
var _total_attempts: int = -1

@onready var vb_complete: VBoxContainer = $VBComplete
@onready var music: AudioStreamPlayer = $Music
@onready var attempts_number_label: Label = $MC/VBLevelInfo/HBAttempts/AttemptsNumberLabel
@onready var press_escape_label: Label = $VBComplete/PressEscapeLabel
@onready var level_number_label: Label = $MC/VBLevelInfo/HBLevel/LevelNumberLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	_total_cups = get_tree().get_nodes_in_group(Cup.GROUP_NAME).size()
	print("total_cups %d" % _total_cups)
	SignalHub.on_cup_destroyed.connect(on_cup_destroyed)
	SignalHub.on_attempt_made.connect(on_attempt_made)
	on_attempt_made()
	level_number_label.text = str(ScoreManager.level_selected)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		GameManager.change_to_main_scene()

func on_attempt_made() -> void:
	_total_attempts += 1
	attempts_number_label.text = "%d" % _total_attempts

func on_cup_destroyed() -> void:
	_current_cups += 1
	if _current_cups >= _total_cups:
		vb_complete.show()
		music.play()
		ScoreManager.set_level_best(_total_attempts)
		get_tree().paused = true
