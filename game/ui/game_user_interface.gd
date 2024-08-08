class_name GameUserInterface
extends CanvasLayer

const PAUSE_SCENE: PackedScene = preload("res://game/ui/screens/pause_screen.tscn")
const GAME_OVER_SCENE: PackedScene = preload("res://game/ui/screens/game_over_screen.tscn")

@export var game: Game
@export var gameplay: Gameplay
@export var pause_system: PauseSystem
@export var score_system: ScoreSystem

var _pause_screen: PauseScreen
var _game_over_screen: GameOverScreen


func _ready():
	pause_system.paused.connect(_on_game_paused)
	gameplay.game_over.connect(_on_game_over)

func _on_game_over() -> void:
	print("Game over")
	_game_over_screen = GAME_OVER_SCENE.instantiate()
	_game_over_screen.gameplay = gameplay
	_game_over_screen.score_system = score_system
	_game_over_screen.restarted.connect(_on_game_over_restarted)
	_game_over_screen.quitted.connect(_on_game_over_quitted)
	add_child(_game_over_screen)

func _on_game_over_restarted():
	_game_over_screen.queue_free()
	game.restart_game()

func _on_game_over_quitted():
	_game_over_screen.queue_free()
	game.quit_to_menu()

func _on_game_paused() -> void:
	_pause_screen = PAUSE_SCENE.instantiate()
	_pause_screen.resumed.connect(_unpause)
	_pause_screen.restarted.connect(_on_pause_restarted)
	_pause_screen.quitted.connect(_on_pause_quitted)
	add_child(_pause_screen)

func _on_pause_restarted():
	_unpause()
	game.restart_game()

func _on_pause_quitted():
	_unpause()
	game.quit_to_menu()

func _unpause() -> void:
	_pause_screen.queue_free()
	pause_system.unpause_game()
