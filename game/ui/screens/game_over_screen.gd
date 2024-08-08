class_name GameOverScreen
extends Control

@export var gameplay: Gameplay
@export var score_system: ScoreSystem
@export var transition_options: SceneTransitionOptions

@onready var score_value_label: Label = %ScoreValueLabel
@onready var level_value_label: Label = %LevelValueLabel
@onready var lines_value_label: Label = %LinesValueLabel

func _ready():
	transition_options.create()

	score_value_label.text = "%d" % score_system.current_score
	level_value_label.text = "%d" % gameplay.level
	lines_value_label.text = "%d" % gameplay.lines_removed_total
	
func restart_game() -> void:
	SceneManager.change_scene("game", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)

func quit() -> void:
	SceneManager.change_scene("main_menu", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)
