extends Spatial

func _process(delta):
	if GLOBAL.boton1_pressed == true:
		if GLOBAL.boton2_pressed == true:
			if GLOBAL.boton3_pressed == true:
				print("LEVEL CLEARED")
				get_tree().change_scene("res://test_room.tscn")
