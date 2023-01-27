extends PuzzleClass

export(Vector3) var target_translation
export(Vector3) var target_rotation_degrees


onready var origin_translation = translation
onready var origin_rotation_degrees = rotation_degrees

func active():
	
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	
	if target_translation != Vector3.ZERO:
		tween.tween_property(self,"translation", target_translation, time_transition)
	
	if target_rotation_degrees != Vector3.ZERO:
		tween.parallel().tween_property(self,"rotation_degrees", target_rotation_degrees, time_transition)

func disable():
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(self,"translation", origin_translation, time_transition / 2)
	tween.parallel().tween_property(self,"rotation_degrees", origin_rotation_degrees, time_transition / 2)
