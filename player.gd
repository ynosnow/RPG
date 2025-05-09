extends CharacterBody2D

@export var inventory_data: InventoryData
@export var max_hp: int = 100
var current_hp: int = max_hp
var can_move = true

const speed = 100.0

func apply_damage(amount: int) -> void:
	current_hp = max(0, current_hp - amount)

func _ready():
	current_hp = max_hp

func _physics_process(_delta: float) -> void:
	if not can_move:
		return
	movement()
	position = position.round()

func movement():
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	if velocity.x < 0:
		%MainCharakterLeft.visible = true
		%MainCharakterRight.visible = false
		%MainCharakterBack.visible = false
		%MainCharakterFront.visible = false
	if velocity.x > 0:
		%MainCharakterLeft.visible = false
		%MainCharakterRight.visible = true
		%MainCharakterBack.visible = false
		%MainCharakterFront.visible = false
	if velocity.y < 0:
		%MainCharakterLeft.visible = false
		%MainCharakterBack.visible = true
		%MainCharakterRight.visible = false
		%MainCharakterFront.visible = false
	if velocity.y > 0:
		%MainCharakterLeft.visible = false
		%MainCharakterFront.visible = true
		%MainCharakterRight.visible = false
		%MainCharakterBack.visible = false
	move_and_slide()
