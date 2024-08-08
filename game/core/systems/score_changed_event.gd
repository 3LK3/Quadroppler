class_name ScoreChangedEvent
extends RefCounted

var score: int
var points_added: int
var action_text: String
var level: int

func _init(p_score: int, p_points_added: int, p_action_text: String, p_level: int):
	score = p_score
	points_added = p_points_added
	action_text = p_action_text
	level = p_level
