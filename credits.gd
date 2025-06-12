extends Control

@onready var label = $RichTextLabel as RichTextLabel
@onready var music = $test as AudioStreamPlayer2D
@onready var label2 = $RichTextLabel2 as RichTextLabel

func _ready():
	music.play()

	await get_tree().process_frame  # Wait a frame so sizes update

	var screen_size = get_viewport_rect().size
	var screen_width = screen_size.x
	var screen_height = screen_size.y

	var label_height = label.get_content_height()
	var label_width = label.size.x  # use size property

	# Center horizontally
	label.position.x = (screen_width - label_width) / 2

	# Start below the screen
	label.position.y = screen_height

	# Animate scrolling upward
	var tween = create_tween()
	var target_y = -label_height

	tween.tween_property(label, "position:y", target_y, 60.0) \
		.set_trans(Tween.TRANS_LINEAR) \
		.set_ease(Tween.EASE_IN_OUT)

	await tween.finished

	get_tree().quit()
