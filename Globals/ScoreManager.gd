extends Node

#const LEVEL_SCORES: LevelScoresResource = preload("uid://bs8nt7kg20uik")
const SCORES_PATH: String = "user://animals_scores.res"

var level_selected: int = 1:
	get: return level_selected
	set(value): level_selected = value

var _level_scores: LevelScoresResource = LevelScoresResource.new()

func _ready() -> void:
	load_scores_from_file()
	print(_level_scores.get_level_best(1))

func get_level_best(level: int) -> int:
	return _level_scores.get_level_best(level)

func set_level_best(score: int) -> void:
	_level_scores.try_to_update_best(level_selected, score)
	save_scores_to_file()

func load_scores_from_file() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		_level_scores = ResourceLoader.load(SCORES_PATH)

func save_scores_to_file() -> void:
	ResourceSaver.save(_level_scores, SCORES_PATH)
