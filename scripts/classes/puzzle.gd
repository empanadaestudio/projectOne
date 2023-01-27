extends Spatial
class_name PuzzleClass

export(int, "All Actions", "In Order") var mode
export(float) var time_transition = 0.5

export var exclusive := false
export var actionables : Array = [NodePath()]



onready var box : CSGBox = $CSGBox

var all_actions_active : Array
var actionable_instances : Array

var steps_complete := 0

func _ready():
	if actionables.size() > 0:
		for i in actionables.size():
			var b_instance = get_node(actionables[i])
			b_instance.connect("pressed",self,"step")
			b_instance.connect("released",self,"step")
			actionable_instances.append(b_instance)
		
		match mode:
			0:
				all_actions_active.resize(actionable_instances.size())
				all_actions_active.fill(false)

func step(interactuable, msg := {}):
	match mode:
		0:
			if exclusive:
				steps_complete = 0
				
				var pos = actionable_instances.find(interactuable)
				all_actions_active[pos] = msg.active
				
				for pressed in all_actions_active:
					if pressed:
						steps_complete += 1
				
				if steps_complete == all_actions_active.size():
					active()
				else:
					disable()
			else:
				steps_complete = 0
				
				var pos = actionable_instances.find(interactuable)
				all_actions_active[pos] = msg.active
				
				for active in all_actions_active:
					if active:
						steps_complete += 1
				
				if steps_complete == all_actions_active.size():
					active()

func active():
	pass

func disable():
	pass
