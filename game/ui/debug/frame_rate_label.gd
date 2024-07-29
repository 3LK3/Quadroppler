class_name FramesPerSecondLabel
extends Label

func _process(_delta: float):
	text = "%03.1f FPS" % Engine.get_frames_per_second()
