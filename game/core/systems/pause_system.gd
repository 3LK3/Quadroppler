class_name PauseSystem
extends Node

signal paused
signal unpaused

func pause_game() -> void:
	get_tree().paused = true
	paused.emit()

func unpause_game() -> void:
	get_tree().paused = false
	unpaused.emit()

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("pause"):
		pause_game()