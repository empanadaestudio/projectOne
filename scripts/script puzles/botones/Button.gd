extends Area

onready var button_box = $CSGBox
onready var hitbox = $CollisionShape

func _ready():
	connect("area_entered", self, "button_pressed")
	connect("area_exited", self, "button_released")

func button_pressed(area):
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(button_box,"translation:y", -0.5, 0.33)
	

func button_released(area):
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(button_box,"translation:y", hitbox.translation.y, 0.33)
