extends CharacterBody2D

const speed = 100.0

func _physics_process(_delta: float) -> void:
	movement()

func movement():
	velocity = Input.get_vector("left", "right", "up", "down")*speed
	move_and_slide()
