class_name Gameplay
extends Node

signal game_over
signal level_changed(new_level: int)
signal lines_removed(lines: int)

@export var board: PieceControlSystem
@export var level: int = 1
@export var lines_per_level: int = 10

var lines_removed_count: int:
	get():
		return _lines_removed_count

var _is_game_running: bool = false

var _tick_speed: float = 0.0
var _tick_interval: float = 0.0

var _lines_removed_count: int = 0

func is_game_running() -> bool:
	return _is_game_running

func start_game() -> void:
	_is_game_running = true
	_spawn_next_tile()

func stop_game() -> void:
	_is_game_running = false

func _ready():
	_update_tick_speed()
	board.piece_locked.connect(_on_piece_locked)

func _input(_event):
	var horizontal_movement: float = Input.get_axis("move_left", "move_right")
	if horizontal_movement != 0.0:
		board.move_piece_horizontal(roundi(horizontal_movement))

	if Input.is_action_pressed("rotate_cw"):
		board.rotate_piece()

	if Input.is_action_pressed("drop_soft"):
		_tick()

func _process(delta):
	if _is_game_running:
		_tick_interval += delta
		if _tick_interval >= _tick_speed:
			_tick()

func _on_piece_locked(lines: int) -> void:
	if lines > 0:
		_lines_removed_count += lines
		print("Removed %d lines (%d total)" % [lines, _lines_removed_count])

		if _lines_removed_count >= lines_per_level:
			_increase_level()
			_lines_removed_count -= lines_per_level
		
		lines_removed.emit(lines)

	_spawn_next_tile()

func _spawn_next_tile() -> void:
	var next_piece: PieceData = PieceDefinitionSystem.get_next_piece()
	if not board.spawn_piece(next_piece):
		stop_game()
		game_over.emit()
	else:
		PieceDefinitionSystem.set_next_piece()

func _tick() -> void:
	board.tick()
	# reset the tick interval so it starts again
	_tick_interval = 0.0

func _increase_level() -> void:
	level += 1
	_update_tick_speed()
	level_changed.emit(level)

func _update_tick_speed() -> void:
	_tick_speed = pow(0.8 - ((level - 1) * 0.007), level - 1)
	print("Level=%d Speed=%f" % [level, _tick_speed])
