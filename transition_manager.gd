extends CanvasLayer

@export var bar_count: int = 8
@export var transition_duration: float = 2.9 
@export var scene_path: String = "res://Battle.tscn"

var bars := []
var is_transitioning := false

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	var bar_height = screen_size.y / bar_count

	for i in range(bar_count):
		var bar = ColorRect.new()
		bar.color = Color.BLACK
		bar.size = Vector2(screen_size.x, bar_height)
		bar.position = Vector2(0, i * bar_height)
		bar.pivot_offset = bar.size / 2
		bar.rotation_degrees = 0
		bar.scale.x = 0  
		add_child(bar)
		bars.append(bar)

func play_transition():
	if is_transitioning:
		return
	is_transitioning = true

	
	for bar in bars:
		bar.scale.x = 0

	var stagger_time = transition_duration / bar_count
	
	self.visible = true  

	for i in range(bar_count):
		var bar = bars[i]
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(bar, "scale:x", 1, 0.3).set_delay(i * stagger_time)

	var total_delay = stagger_time * bar_count + 0.3 - 0.1  
	await get_tree().create_timer(total_delay).timeout

	get_tree().change_scene_to_file(scene_path)

	self.visible = false 
	is_transitioning = false
