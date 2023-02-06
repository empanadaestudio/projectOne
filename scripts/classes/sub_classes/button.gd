extends InteractableClass
class_name ButtonClass

onready var area = $Area

var pressed := false

func _ready():
	area.connect("area_entered", self, "button_pressed")
	area.connect("area_exited", self, "button_released")
	
	area.connect("body_entered", self, "button_pressed")
	area.connect("body_exited", self, "button_released")

func button_pressed(other):
	if other.is_in_group("player") or other.is_in_group("pickeable"):
#		var tween := create_tween()
#		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
#		tween.tween_property(button_box,"translation:y", -0.4, 0.2)
#
		pressed = true
		
		args.state = pressed
		
		activated(args)

func button_released(other):
	if other.is_in_group("player") or other.is_in_group("pickeable"):
#		var tween := create_tween()
#		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
#		tween.tween_property(button_box,"translation:y", hitbox.translation.y, 0.2)
#
		pressed = false
		
		args.state = pressed
		
		desactive(args)

