class_name PiecePreview
extends Control

@onready var preview_viewport = %PreviewViewport

const _PIECE_SCENE: PackedScene = preload ("res://game/core/pieces/piece.tscn")
var _preview_piece: Piece

func _ready():
	PieceDefinitionSystem.next_piece_set.connect(_on_next_piece_set)
	
func _on_next_piece_set(next_piece: PieceData) -> void:
	if is_instance_valid(_preview_piece):
		_preview_piece.queue_free()
	
	_preview_piece = _PIECE_SCENE.instantiate()
	_preview_piece.piece_data = next_piece
	# _preview_piece.tile_texture = tile_texture
	_preview_piece.position = Vector2.ZERO
	preview_viewport.add_child(_preview_piece)
