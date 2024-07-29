class_name SceneTransitionOptions
extends Resource

@export var fade_out_speed: float = 1.0
@export var fade_in_speed: float = 1.0
@export var fade_out_pattern: String = "fade"
@export var fade_in_pattern: String = "fade"
@export var fade_out_smoothness: float = 0.1 # (float, 0, 1)
@export var fade_in_smoothness: float = 0.1 # (float, 0, 1)
@export var fade_out_inverted: bool = false
@export var fade_in_inverted: bool = false
@export var color: Color = Color(0, 0, 0)
@export var timeout: float = 0.0
@export var clickable: bool = false
@export var add_to_back: bool = true

var fade_out_options: SceneManager.Options = null
var fade_in_options: SceneManager.Options = null
var general_options: SceneManager.GeneralOptions = null

func create() -> void:
	fade_out_options = SceneManager.create_options(fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted)
	fade_in_options = SceneManager.create_options(fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted)
	general_options = SceneManager.create_general_options(color, timeout, clickable, add_to_back)
