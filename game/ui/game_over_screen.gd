class_name GameOverScreen
extends Control

@export var transition_options: SceneTransitionOptions

func _ready():
	transition_options.create()
	
func restart_game() -> void:
	SceneManager.change_scene("game", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)

func quit() -> void:
	SceneManager.change_scene("main_menu", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)
