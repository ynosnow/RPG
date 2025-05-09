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
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_slide()
