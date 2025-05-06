extends CharacterBody2D

@export var inventory_data: InventoryData

const speed = 100.0


func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_slide()
