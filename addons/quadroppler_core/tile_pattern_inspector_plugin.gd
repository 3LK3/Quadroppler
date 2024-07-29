class_name TilePatternInspectorPlugin
extends EditorInspectorPlugin

var _coordinates_editor = preload ("res://addons/quadroppler_core/tile_pattern_coordinates_editor.gd")

func _can_handle(object) -> bool:
	return object is PieceRotationState

func _parse_property(object: Object, type: int, name: String, hint_type: int, hint_string: String, usage_flags: int, wide: bool) -> bool:
	if name == "coordinates":
		if type != TYPE_ARRAY or hint_type != PROPERTY_HINT_TYPE_STRING or not hint_string.begins_with(str(TYPE_VECTOR2I)):
			print("Coordinates of PieceRotationState has to be an Array[Vector2i]")
			return false
		add_property_editor(name, _coordinates_editor.new())
		return true
	return false
