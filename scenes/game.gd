class_name Game
extends Node

@onready var gameplay: Gameplay = %Gameplay

var game_over_scene: PackedScene = preload ("res://game/ui/screens/game_over_screen.tscn")
var _game_over_screen: GameOverScreen

func _ready():
	print("Ready to start")
	# set the next piece initially
	PieceDefinitionSystem.set_next_piece()

	gameplay.game_over.connect(_on_game_over)
	gameplay.start_game()

func _on_game_over() -> void:
	print("Game over")
	_game_over_screen = game_over_scene.instantiate()
	%GameUserInterface.add_child(_game_over_screen)
