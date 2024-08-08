class_name PauseScreen
extends Control

signal resumed
signal restarted
signal quitted


func resume_game() -> void:
	resumed.emit()

func restart_game() -> void:
	restarted.emit()

func quit() -> void:
	quitted.emit()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		resume_game()
