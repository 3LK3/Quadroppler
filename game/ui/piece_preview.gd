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
	_preview_piece.position = Vector2.ZERO
	if next_piece.get_bounding_box_size().y > 2:
		# Center pieces: explicitly made for standard pieces.
		# Just move pieces down if y > 2 (not the cube) to center them.
		# Works for default pieces. May not work for others.
		_preview_piece.position.y += 0.5 * 32.0
		
	preview_viewport.add_child(_preview_piece)
	
