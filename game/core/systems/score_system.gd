class_name ScoreSystem
extends Node

signal score_changed(event: ScoreChangedEvent)

@export var gameplay: Gameplay

@export_category("Multipliers")
@export var single: int = 100
@export var double: int = 300
@export var triple: int = 500
@export var quadrople: int = 800

var current_score: int:
	get:
		return _current_score

var _current_score: int = 0

func _ready():
	gameplay.lines_removed.connect(_on_lines_removed)

func _on_lines_removed(lines: int, _total_lines: int, level: int) -> void:
	if lines not in range(1, 5):
		print("That should never happen. Signal should only fire 1 to 4 lines removed.")
		return

	match lines:
		1:
			_add_to_score("Single", single, level)
		2:
			_add_to_score("Double", double, level)
		3:
			_add_to_score("Triple", triple, level)
		4:
			_add_to_score("Quadrople", quadrople, level)

func _add_to_score(action_text: String, points_multiplier: int, level: int) -> void:
	print("Score + %d x %d" % [points_multiplier, level])
	var add: int = points_multiplier * level
	_current_score += add
	score_changed.emit(ScoreChangedEvent.new(_current_score, add, action_text, level))