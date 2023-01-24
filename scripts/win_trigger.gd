extends CSGCombiner

export(int, "todos", "progresivo", "secuencial") var mode
export var exclusive := false
export var buttons : Array = []

onready var box : CSGBox = $CSGBox

var all_button_presseds : Array
var buttons_instances : Array

var steps_complete := 0
var level_passed := false


func _ready():
	if buttons.size() > 0:
		for i in buttons.size():
			var b_instance = get_node(buttons[i])
			b_instance.connect("pressed",self,"step")
			b_instance.connect("released",self,"step")
			buttons_instances.append(b_instance)
		
		match mode:
			0:
				all_button_presseds.resize(buttons_instances.size())
				all_button_presseds.fill(false)


func step(button, msg := {}):
	match mode:
		0:
			if exclusive:
				steps_complete = 0
				
				var pos = buttons_instances.find(button)
				all_button_presseds[pos] = msg._pressed
				
				for pressed in all_button_presseds:
					if pressed:
						steps_complete += 1
				
				
				if steps_complete == all_button_presseds.size():
					level_passed = true
					open_door()
				else:
					level_passed = false
					close_door()
			else:
				
				steps_complete = 0
				
				var pos = buttons_instances.find(button)
				all_button_presseds[pos] = msg._pressed
				
				for pressed in all_button_presseds:
					if pressed:
						steps_complete += 1
				
				
				if steps_complete == all_button_presseds.size() and not level_passed:
					level_passed = true
					open_door()
				

func open_door():
	box.visible = false

func close_door():
	box.visible = true
