extends Control


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(fade):
	$Container/Sprite/AnimationPlayer2.play("out")

func _on_AnimationPlayer2_animation_finished(out):
	get_tree().change_scene("res://GUI Scenes/MainMenu.tscn")
