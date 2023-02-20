extends Spatial
class_name PuzzleClass

export(int, "All Actions", "In Order") var mode
export(float) var time_transition = 0.5

export var exclusive := false
export var actionables : Array = [NodePath()]

var in_order_active : Array
var all_actions_active : Array

var actionable_instances : Array

var steps_complete := 0

func _ready():
	if actionables.size() > 0:
		for i in actionables.size():
			var b_instance = get_node(actionables[i])
			b_instance.connect("active",self,"step")
			b_instance.connect("desactive",self,"step")
			actionable_instances.append(b_instance)
		
		match mode:
			0:
				all_actions_active.resize(actionable_instances.size())
				all_actions_active.fill(false)
			1:
				in_order_active.resize(0)

func step(interactuable, msg := InteractableClass.args):
	match mode:
		0:
			if exclusive:
				
				steps_complete = 0
				
				var pos = actionable_instances.find(interactuable)
				all_actions_active[pos] = msg.state
				
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
				all_actions_active[pos] = msg.state
				
				for active in all_actions_active:
					if active:
						steps_complete += 1
				
				if steps_complete == all_actions_active.size():
					active()
		1:
			if exclusive:
				var actionable = actionable_instances.find(interactuable)
				
				if msg.state:
					if not msg.order in in_order_active:
						in_order_active.append(msg.order)
						steps_complete += 1
						
					
					if steps_complete == actionable_instances.size():
						
						var array_original = in_order_active.duplicate()
						in_order_active.sort()
						if array_original == in_order_active:
							active()
				else:
					var index = in_order_active.find(msg.order)
					in_order_active.remove(index)
					steps_complete -= 1
					disable()
			else:
				
				var actionable = actionable_instances.find(interactuable)
				if not msg.order in in_order_active:
					in_order_active.append(msg.order)
					steps_complete += 1
					
					if steps_complete == actionable_instances.size():
						
						var array_original = in_order_active.duplicate()
						in_order_active.sort()
						if array_original == in_order_active:
							active()
						else:
							in_order_active.resize(0)
							steps_complete = 0
						
					

func active():
	pass

func disable():
	pass
