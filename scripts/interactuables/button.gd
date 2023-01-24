extends Area

export var order := 1

onready var button_box = $CSGBox
onready var hitbox = $CollisionShape

signal pressed
signal released

var pressed := false

func _ready():
	connect("area_entered", self, "button_pressed")
	connect("area_exited", self, "button_released")

func button_pressed(area):
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(button_box,"translation:y", -0.5, 0.33)
	
	pressed = true
	emit_signal("pressed", self, {_order = order, _pressed = pressed})

func button_released(area):
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(button_box,"translation:y", hitbox.translation.y, 0.33)
	
	pressed = false
	emit_signal("released", self, {_pressed = pressed})

