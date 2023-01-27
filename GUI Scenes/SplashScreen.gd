extends Control


func _on_AnimationPlayer_animation_finished(fade):
	$Container/Sprite/AnimationPlayer2.play("out")
	$Whoosh.play()

func _on_AnimationPlayer2_animation_finished(out):
	get_tree().change_scene("res://GUI Scenes/MainMenu.tscn")
