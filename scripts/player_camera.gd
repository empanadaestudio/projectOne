extends Spatial

export(NodePath) var camera_path
export(NodePath) var target_path
export var transition_duration := 1.5

onready var camera = get_node(camera_path)
onready var target = get_node(target_path)

var position_nodes : Array
var area_nodes : Array

var camera_can_move := true
var camera_pos := 0
var new_position

func _ready():
	for area in get_children():
		area.connect("area_entered",self, "connect_area", [area])
		area_nodes.append(area)
	
	for pos in area_nodes[0].get_children():
		if pos is Position3D:
			position_nodes.append(pos)
	
	new_position = position_nodes[camera_pos]
	
	camera.global_translation = new_position.global_translation

func connect_area(other_area, area):
	
	if other_area.is_in_group("player"):
		
		if camera_pos != 0:
			var tween := create_tween()
			tween.tween_property(camera,"global_translation", position_nodes[0].global_translation, transition_duration)
			yield(tween, "finished")
		
		position_nodes.clear()
		for pos in area.get_children():
			if pos is Position3D:
				position_nodes.append(pos)
	
	camera_pos = 0
	move_camera()

func _input(event):
	if event.is_action_pressed("ui_camera_left") and camera_can_move:
		camera_pos -= 1
		move_camera()
	elif event.is_action_pressed("ui_camera_right") and camera_can_move:
		camera_pos += 1
		move_camera()


func _process(delta):
	camera.look_at(Vector3(target.translation.x,0,target.translation.z), Vector3.UP)
	pass

func move_camera():
	
	camera_can_move = false
	var tween := create_tween()
	
	var max_positions = position_nodes.size() - 1
	
	if camera_pos > max_positions:
		camera_pos = 0
	elif camera_pos < 0:
		camera_pos = max_positions
	
	new_position = position_nodes[camera_pos]
	
	
	tween.tween_property(camera,"global_translation", new_position.global_translation, transition_duration)
	
	yield(tween, "finished")
	camera_can_move = true
