class_name PieceControlSystem
extends Node

signal piece_locked(lines_removed: int)

@export var tile_system: TileSystem

@export_category("Tile")
@export var tile_texture: Texture2D

var _piece_scene: PackedScene = preload("res://game/core/pieces/piece.tscn")

var _controlled_piece: Piece = null
var _controlled_piece_grid_position: Vector2i

## Moves the controlled piece horizontally.
func move_piece_horizontal(movement: int) -> void:
	if _controlled_piece and is_instance_valid(_controlled_piece) and _can_move_piece_horizontally(movement):
		_move_piece(Vector2i(movement, 0))

## Rotates the controlled piece 90 degrees clockwise.
func rotate_piece() -> void:
	if _controlled_piece and is_instance_valid(_controlled_piece) and _can_rotate_piece():
		_controlled_piece.rotate_piece()
	
## Spawns a new controlled piece from the given data.
func spawn_piece(piece_data: PieceData) -> bool:
	# Spawns centered 
	_controlled_piece_grid_position = Vector2i(floori(tile_system.columns / 2.0) - ceili(piece_data.get_bounding_box_size().x / 2.0), 0)
	if _can_spawn_piece(piece_data, _controlled_piece_grid_position):
		# TODO: may check specificly with just cell_coords instead of collision coords
		return false

	_controlled_piece = _piece_scene.instantiate()
	_controlled_piece.tile_texture = tile_texture
	_controlled_piece.piece_data = piece_data
	_controlled_piece.position = _get_piece_center_position(_controlled_piece_grid_position, piece_data)
	add_child(_controlled_piece)

	return true

## Next tick. Moves the controlled piece down by one grid cell.
func tick() -> void:
	_move_piece_down_or_lock()

func _can_move_piece_down() -> bool:
	for tile_coord: Vector2i in _controlled_piece._piece_data.get_coordinates():
		if tile_system.does_collide(_controlled_piece_grid_position + tile_coord + Vector2i.DOWN):
			return false
	return true

func _can_move_piece_horizontally(grid_movement: int) -> bool:
	for tile_coord: Vector2i in _controlled_piece._piece_data.get_coordinates():
		if tile_system.does_collide(_controlled_piece_grid_position + tile_coord + Vector2i(grid_movement, 0)):
			return false
	return true

func _can_rotate_piece() -> bool:
	var next: int = _controlled_piece.piece_data.get_next_rotation_state()
	for tile_coord: Vector2i in _controlled_piece.piece_data.rotation_states[next].coordinates:
		if tile_system.does_collide(_controlled_piece_grid_position + tile_coord):
			return false
	return true
	
func _can_spawn_piece(piece_data: PieceData, piece_position: Vector2i) -> bool:
	for tile_coord: Vector2i in piece_data.get_coordinates():
		if tile_system.has_tile(piece_position + tile_coord):
			print("Cannot spawn because of tile at %s" % (piece_position + tile_coord))
			return true
	return false
	
func _get_piece_center_position(grid_position: Vector2i, piece_data: PieceData) -> Vector2:
	var box: Vector2i = piece_data.get_bounding_box_size()
	var box_center: Vector2 = Vector2((box.x * 32) / 2.0, (box.y * 32) / 2.0)
	
	# some pieces bounding box exceeds the range of the tile system. in those cases we have to add the offset manually
	if grid_position.x < 0:
		# take the coordinate of the first column and add the offset into negative
		return tile_system.get_local_position(Vector2i(0, grid_position.y)) + Vector2(grid_position.x * 32, 0) + box_center
	elif grid_position.x >= tile_system.columns:
		# take the last column and add overflowing offset
		return tile_system.get_local_position(Vector2i(tile_system.columns - 1, grid_position.y)) + Vector2((tile_system.columns - grid_position.x) * 32, 0) + box_center
	else:
		return tile_system.get_local_position(grid_position) + box_center

func _move_piece(grid_movement: Vector2i) -> void:
	_controlled_piece_grid_position += grid_movement
	_controlled_piece.position = _get_piece_center_position(_controlled_piece_grid_position, _controlled_piece.piece_data)

func _lock_piece() -> void:
	for tile_coord: Vector2i in _controlled_piece.piece_data.get_coordinates():
		tile_system.set_tile(_controlled_piece_grid_position + tile_coord, _controlled_piece)

	_controlled_piece.queue_free()
	_controlled_piece = null

	var completed_lines: int = tile_system.remove_completed_lines()
	piece_locked.emit(completed_lines)

func _move_piece_down_or_lock() -> void:
	if not _controlled_piece or not is_instance_valid(_controlled_piece):
		return

	if _can_move_piece_down():
		_move_piece(Vector2i.DOWN)
	else:
		for tile_coord: Vector2i in _controlled_piece.piece_data.get_coordinates():
			tile_system.set_tile(_controlled_piece_grid_position + tile_coord, _controlled_piece)

		_controlled_piece.queue_free()
		_controlled_piece = null

		var completed_lines = tile_system.remove_completed_lines()

		piece_locked.emit(completed_lines)
