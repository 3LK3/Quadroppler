class_name TilePatternCoordinatesEditor
extends EditorProperty

var _grid: GridContainer = GridContainer.new()
var _grid_size: Vector2i

var _tile_buttons: Dictionary

func _init() -> void:
	add_child(_grid)

func _update_property() -> void:
	var tile_pattern: PieceRotationState = get_edited_object()
	if tile_pattern.bounding_box_size != _grid_size:
		_create_grid(tile_pattern.bounding_box_size, tile_pattern.coordinates)

func _create_grid(bounding_box_size: Vector2i, coordinates: Array[Vector2i]) -> void:
	_tile_buttons.clear()
	for child: Node in _grid.get_children():
		child.queue_free()

	_grid.columns = bounding_box_size.x
	
	for y: int in range(bounding_box_size.y):
		for x: int in range(bounding_box_size.x):
			var coord: Vector2i = Vector2i(x, y)
			var tile_button: Button = Button.new()
			tile_button.custom_minimum_size = Vector2(55, 55)
			tile_button.add_theme_font_size_override("font_size", 10)
			tile_button.toggle_mode = true
			tile_button.text = "%d x %d" % [coord.x, coord.y]
			tile_button.pressed.connect(_on_tile_button_pressed)

			if coord in coordinates:
				tile_button.button_pressed = true

			_grid.add_child(tile_button)
			_tile_buttons[coord] = tile_button

func _get_coordinates() -> Array[Vector2i]:
	var new_coords: Array[Vector2i]
	for coord: Vector2i in _tile_buttons:
		if _tile_buttons[coord].button_pressed:
			new_coords.append(coord)
	return new_coords

func _on_tile_button_pressed() -> void:
	emit_changed("coordinates", _get_coordinates())
