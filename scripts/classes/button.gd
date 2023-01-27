extends Area
class_name ButtonClass

export var order := 1

onready var button_box = $Box
onready var hitbox = $CollisionShape

signal pressed(node, arg)
signal released(node, arg)

var pressed := false

func _ready():
	connect("area_entered", self, "button_pressed")
	connect("area_exited", self, "button_released")
	
	connect("body_entered", self, "button_pressed")
	connect("body_exited", self, "button_released")

func button_pressed(other):
	if other.is_in_group("player") or other.is_in_group("pickeable"):
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		tween.tween_property(button_box,"translation:y", -0.4, 0.2)
		
		pressed = true
		emit_signal("pressed", self, {_order = order, active = pressed})

func button_released(other):
	if other.is_in_group("player") or other.is_in_group("pickeable"):
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		tween.tween_property(button_box,"translation:y", hitbox.translation.y, 0.2)
		
		pressed = false
		emit_signal("released", self, {active = pressed})

