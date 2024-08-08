class_name ScoreActionLabel
extends Control

@export var points: int
@export var action_text: String
@export var level_multiplier: int = 1
@export var animation_duration: float = 5.0

@onready var score_added_label: Label = %ScoreAddedPointsLabel
@onready var score_action_label: Label = %ScoreActionLabel
# @onready var level_multiplier_label: Label = %LevelMuliplierLabel

func _ready():
	score_added_label.text = "+ %d" % points
	score_action_label.text = action_text

	# if level_multiplier > 1:
	# 	level_multiplier_label.text = "x %d" % level_multiplier
	# 	level_multiplier_label.show()

	var tween: Tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, 200), animation_duration)
	tween.tween_callback(func(): queue_free())
