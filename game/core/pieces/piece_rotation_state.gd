@tool
@icon("res://assets/icons/Piece_00.svg")
class_name PieceRotationState
extends Resource
## Data representation of a tile pattern aka a the coordinates of a piece.

@export var bounding_box_size: Vector2i
@export var coordinates: Array[Vector2i]
