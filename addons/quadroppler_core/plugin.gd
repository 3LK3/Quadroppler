@tool
extends EditorPlugin

var tile_pattern_plugin: TilePatternInspectorPlugin

func _enter_tree():
	tile_pattern_plugin = preload ("res://addons/quadroppler_core/tile_pattern_inspector_plugin.gd").new()
	add_inspector_plugin(tile_pattern_plugin)

func _exit_tree():
	remove_inspector_plugin(tile_pattern_plugin)
