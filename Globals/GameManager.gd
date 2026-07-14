extends Node

const MAIN = preload("uid://dwtd3gppj3ncn")
const TRANSITIONER = preload("uid://mxhkya0tcdce")

var next_scene: PackedScene = null
var transitioner: Transitioner = null

func _ready() -> void:
	transitioner = TRANSITIONER.instantiate()
	add_child(transitioner)


func change_to_next_scene() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
	
func start_transition(to_scene: PackedScene) -> void:
	next_scene = to_scene
	transitioner.play_anim()

func change_to_main_scene() -> void:
	start_transition(MAIN)

func change_to_level_scene(level_number: int) -> void:
	start_transition(load("res://Scenes/LevelBase/Level%d.tscn" % level_number))
