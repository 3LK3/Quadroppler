class_name TileSystem
extends Node2D

@export var columns: int = 10
@export var rows: int = 20

@export_category("Tiles")
@export var tile_size: Vector2i = Vector2i(32, 32)

const _TILE_SCENE: PackedScene = preload ("res://game/core/tiles/tile.tscn")

var _tile_positions: Array[TilePosition]

func does_collide(grid_position: Vector2i) -> bool:
	return grid_position.x not in range(columns) or grid_position.y not in range(rows) or has_tile(grid_position)

func get_local_position(grid_position: Vector2i) -> Vector2:
	return _get_tile_position(grid_position).local_position

func has_tile(grid_position: Vector2i) -> bool:
	return _get_tile_position(grid_position).has_tile()

func remove_completed_lines() -> int:
	var lines: Array[int] = _get_completed_lines()
	lines.sort()

	for line in lines:
		# remove line
		for x in range(columns):
			var tile_position: TilePosition = _get_tile_position(Vector2i(x, line))
			tile_position.tile.queue_free()
			tile_position.tile = null
		# move lines above downwards
		_move_tiles_down(line)

	return lines.size()

func set_tile(grid_position: Vector2i, piece: Piece) -> void:
	var board_tile: Tile = _TILE_SCENE.instantiate()
	board_tile.texture = piece.tile_texture
	board_tile.color = piece.piece_data.color
	_get_tile_position(grid_position).set_tile(board_tile)
	add_child(board_tile)

func _ready():
	_create_tile_positions()

func _get_completed_lines() -> Array[int]:
	var lines: Array[int]
	for y in range(rows):
		var line_complete := true
		for x in range(columns):
			if not has_tile(Vector2i(x, y)):
				line_complete = false
				break
		if line_complete:
			lines.append(y)
	return lines

func _get_tile_position(grid_position: Vector2i) -> TilePosition:
	var index: int = grid_position.y * columns + grid_position.x
	if index < 0 or index >= _tile_positions.size():
		push_warning("No tile found at %s" % grid_position)
		return null
	return _tile_positions[index]

func _create_tile_positions() -> void:
	_tile_positions.clear()

	var size: Vector2 = Vector2(columns * tile_size.x, rows * tile_size.y)
	var top_left_position: Vector2 = -Vector2(size.x / 2.0, size.y / 2.0)

	for y in rows:
		for x in columns:
			var tile_pos: TilePosition = TilePosition.new()
			tile_pos.grid_position = Vector2i(x, y)
			tile_pos.local_position = top_left_position + Vector2(tile_size.x * x, tile_size.y * y)
			_tile_positions.append(tile_pos)

func _move_tiles_down(above_line: int) -> void:
	# go upwards and move each tile down by one
	for y in range(above_line - 1, -1, -1):
		for x in range(columns):
			var from_pos: TilePosition = _get_tile_position(Vector2i(x, y))
			if from_pos.tile:
				_get_tile_position(Vector2i(x, y + 1)).set_tile(from_pos.tile)
				from_pos.tile = null

class TilePosition extends RefCounted:
	var grid_position: Vector2i
	var local_position: Vector2
	var tile: Tile = null

	func set_tile(new_tile: Tile) -> void:
		new_tile.grid_position = grid_position
		new_tile.position = local_position
		tile = new_tile

	func has_tile() -> bool:
		return tile and is_instance_valid(tile)
