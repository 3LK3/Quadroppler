class_name GameOverScreen
extends Control

signal restarted
signal quitted

@export var gameplay: Gameplay
@export var score_system: ScoreSystem

@onready var score_value_label: Label = %ScoreValueLabel
@onready var level_value_label: Label = %LevelValueLabel
@onready var lines_value_label: Label = %LinesValueLabel

func _ready():
	score_value_label.text = "%d" % score_system.current_score
	level_value_label.text = "%d" % gameplay.level
	lines_value_label.text = "%d" % gameplay.lines_removed_total
	
func restart_game() -> void:
	restarted.emit()

func quit() -> void:
	quitted.emit()
