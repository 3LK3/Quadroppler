extends Node

@export var transition_options: SceneTransitionOptions

@onready var title_label: Label = %TitleLabel
@onready var quit_button: Button = %QuitButton

func _ready():
	transition_options.create()

	if OS.has_feature("web"):
		quit_button.hide()

	title_label.text = (ProjectSettings.get_setting("application/config/name") as String).to_lower()

	var bg_color: Color = ProjectSettings.get_setting("application/boot_splash/bg_color")
	SceneManager.show_first_scene(SceneManager.create_options(0.5, "fade"), SceneManager.create_general_options(bg_color, 0.5, false))

func play() -> void:
	SceneManager.change_scene("game", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)

func quit() -> void:
	SceneManager.change_scene("exit", transition_options.fade_out_options, transition_options.fade_in_options, transition_options.general_options)
