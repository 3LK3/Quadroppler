class_name Game
extends Node

@export var transition_options: SceneTransitionOptions

@onready var gameplay: Gameplay = %Gameplay
@onready var score_system: ScoreSystem = %ScoreSystem
@onready var pause_system: PauseSystem = %PauseSystem


func quit_to_menu() -> void:
	gameplay.stop_game()
	SceneManager.change_scene("main_menu", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)

func restart_game() -> void:
	gameplay.stop_game()
	SceneManager.change_scene("game", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)

func _ready():
	print("Ready to start")
	transition_options.create()

	# set the next piece initially
	PieceDefinitionSystem.set_next_piece()

	gameplay.start_game()
