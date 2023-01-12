extends Spatial

export(NodePath) var camera_path
export(NodePath) var target_path

onready var camera = get_node(camera_path)
onready var target = get_node(target_path)

var position_nodes : Array

var camera_can_move := true
var camera_pos := 0
var new_position

func _ready():
	for pos in get_children():
		position_nodes.append(pos)
	
	new_position = position_nodes[camera_pos]
	
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

func move_camera():
	
	camera_can_move = false
	var tween := create_tween()
	
	if camera_pos > position_nodes.size() - 1:
		camera_pos = 0
	elif camera_pos < 0:
		camera_pos = position_nodes.size() - 1
	
	new_position = position_nodes[camera_pos]
	
	tween.tween_property(camera,"translation", new_position.translation, 1)
	
	
	yield(tween, "finished")
	camera_can_move = true
	
