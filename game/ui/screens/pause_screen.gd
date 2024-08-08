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
