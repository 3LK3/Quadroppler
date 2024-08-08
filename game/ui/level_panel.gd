class_name LevelPanel
extends Control

@export var gameplay: Gameplay

@onready var lines_progress_bar: ProgressBar = %LinesProgressBar
@onready var lines_progress_label: Label = %LinesProgressLabel
@onready var current_level_label: Label = %CurrentLevelLabel

func _ready():
	gameplay.level_changed.connect(_on_level_changed)
	gameplay.lines_removed.connect(_on_lines_removed)
	
	lines_progress_bar.max_value = gameplay.lines_per_level
		
	_update_level(gameplay.level)
	_update_lines(0)

func _update_level(level: int) -> void:
	current_level_label.text = "%d" % level

func _update_lines(lines: int) -> void:
	lines_progress_bar.value = lines
	lines_progress_label.text = "%s" % (gameplay.lines_per_level - lines)

func _on_level_changed(new_level: int) -> void:
	_update_level(new_level)
	
func _on_lines_removed(_lines_removed: int, total_lines_removed: int, _level: int) -> void:
	_update_lines(total_lines_removed)
