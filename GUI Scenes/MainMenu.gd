extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://test_room.tscn")


func _on_Button3_pressed():
	get_tree().quit()
