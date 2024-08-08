class_name ScorePanel
extends Control

@export var score_system: ScoreSystem

@onready var current_score_label: Label = %CurrentScoreLabel

const ACTION_LABEL_SCENE: PackedScene = preload("res://game/ui/score_action_label.tscn")

func _ready():
	score_system.score_changed.connect(_on_score_changed)
	_update_current_score(0)

func _on_score_changed(event: ScoreChangedEvent) -> void:
	_update_current_score(event.score)
	_spawn_action_label(event.action_text, event.points_added, event.level)

func _update_current_score(score: int) -> void:
	current_score_label.text = "%d" % score

func _spawn_action_label(action_text: String, points: int, level: int) -> void:
	var action_label: ScoreActionLabel = ACTION_LABEL_SCENE.instantiate()
	action_label.points = points
	action_label.action_text = action_text
	action_label.level_multiplier = level
	add_child(action_label)
	action_label.position.y = 75
