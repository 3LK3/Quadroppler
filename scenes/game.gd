class_name Game
extends Node

@onready var gameplay: Gameplay = %Gameplay
@onready var score_system: ScoreSystem = %ScoreSystem

var game_over_scene: PackedScene = preload("res://game/ui/screens/game_over_screen.tscn")
var _game_over_screen: GameOverScreen

func _ready():
	print("Ready to start")
	# set the next piece initially
	PieceDefinitionSystem.set_next_piece()

	gameplay.game_over.connect(_on_game_over)
	gameplay.start_game()

func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("pause"):
		print("PAUSE")

func _on_game_over() -> void:
	print("Game over")
	_game_over_screen = game_over_scene.instantiate()
	_game_over_screen.gameplay = gameplay
	_game_over_screen.score_system = score_system
	%GameUserInterface.add_child(_game_over_screen)
