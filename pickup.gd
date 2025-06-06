extends RigidBody2D

@export var slot_data: SlotData

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	if Global.if_keys_picked_up:
		queue_free()
		return
	elif Global.chinese_shop_entered:
		queue_free()
		return
	else:
		sprite_2d.texture = slot_data.item_data.texture

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.inventory_data.pick_up_slot_data(slot_data):
		queue_free()
