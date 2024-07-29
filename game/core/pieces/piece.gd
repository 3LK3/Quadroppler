@tool
class_name Piece
extends Node2D

@export var piece_data: PieceData:
	get:
		return _piece_data
	set(value):
		_piece_data = value

@export var tile_texture: Texture2D:
	get:
		return _tile_texture
	set(value):
		_tile_texture = value

const _TILE_SCENE: PackedScene = preload ("res://game/core/tiles/tile.tscn")

var _piece_data: PieceData
var _tile_texture: Texture2D

#var _gizmo_overlay: Node2D

func rotate_piece() -> void:
	rotate(deg_to_rad(90))
	piece_data.rotate()

func _enter_tree():
	_setup_tiles()
	
	#if Engine.is_editor_hint():
		#var viewport: Viewport = EditorInterface.get_editor_viewport_2d()
		#_gizmo_overlay = Node2D.new()
		#_gizmo_overlay.draw.connect(func():
			#_gizmo_overlay.draw_circle(Vector2.ZERO, 6, Color.BLUE)
		#)
		#viewport.add_child(_gizmo_overlay)

#func _exit_tree():
	#if is_instance_valid(_gizmo_overlay):
		#_gizmo_overlay.queue_free()

func _setup_tiles() -> void:
	for child in get_children():
		child.queue_free()

	if is_instance_valid(piece_data):
		var box: Vector2i = piece_data.get_bounding_box_size()
		var x0: float = -(box.x * 32) / 2.0
		var y0: float = -(box.y * 32) / 2.0
		for tile_coord: Vector2i in piece_data.get_coordinates():
			var tile: Tile = _TILE_SCENE.instantiate()
			tile.texture = _tile_texture
			tile.grid_position = tile_coord
			tile.color = piece_data.color
			tile.position = Vector2(x0 + (tile_coord.x * 32), y0 + (tile_coord.y * 32))
			add_child(tile)
