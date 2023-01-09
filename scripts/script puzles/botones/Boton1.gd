extends Area


func _on_Boton1_area_entered(area):
	GLOBAL.boton1_pressed = true
	$AnimationPlayer.play("pressed")

func _on_Boton1_area_exited(area):
	GLOBAL.boton1_pressed = false
	$AnimationPlayer.play("released")

func _on_Boton2_area_entered(area):
	GLOBAL.boton2_pressed = true
	$AnimationPlayer.play("pressed")

func _on_Boton2_area_exited(area):
	GLOBAL.boton2_pressed = false
	$AnimationPlayer.play("released")

func _on_Boton3_area_entered(area):
	GLOBAL.boton3_pressed = true
	$AnimationPlayer.play("pressed")

func _on_Boton3_area_exited(area):
	GLOBAL.boton3_pressed = false
	$AnimationPlayer.play("released")
