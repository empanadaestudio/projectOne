extends InteractableClass
class_name LeverClass

export var on := false

onready var anim_player = $AnimationPlayer

func _ready():
	if on:
		on()
	else:
		off()

func active():
	if not anim_player.is_playing():
		if on:
			off()
		else:
			on()

func on():
	on = true
	anim_player.play("On")
	yield(anim_player, "animation_finished")
	args.state = on
	activated(args)

func off():
	on = false
	anim_player.play("Off")
	yield(anim_player, "animation_finished")
	args.state = on
	desactive(args)
