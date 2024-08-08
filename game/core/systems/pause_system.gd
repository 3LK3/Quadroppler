class_name PauseSystem
extends Node

signal paused
signal unpaused

func pause_game() -> void:
	print("Pause")
	get_tree().paused = true
	paused.emit()

func unpause_game() -> void:
	print("Unpause")
	get_tree().paused = false
	unpaused.emit()

func _unhandled_input(_event: InputEvent):
	if not get_tree().paused and Input.is_action_just_pressed("pause"):
		pause_game()