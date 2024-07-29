@tool
class_name Tile
extends Node2D

@export var texture: Texture2D
@export var color: Color

@onready var tile_sprite = %TileSprite

var grid_position: Vector2i

func _ready():
	modulate = color
	set_texture(texture)

func set_texture(new_texture: Texture2D) -> void:
	tile_sprite.texture = new_texture
