extends Control

func _on_Button_pressed():
	GLOBAL.call_deferred("goto_scene", "res://level.tscn", self)


func _on_Button3_pressed():
	get_tree().quit()
