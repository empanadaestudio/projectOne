extends Spatial

export(NodePath) var camera_path

onready var camera = get_node(camera_path)

var position_nodes : Array

var camera_pos := 0
var new_position

func _ready():
	for pos in get_children():
		position_nodes.append(pos)
	
	new_position = position_nodes[camera_pos]
	move_camera()


func _input(event):
	if event.is_action_pressed("ui_camera_left"):
		camera_pos -= 1
		move_camera()
	elif event.is_action_pressed("ui_camera_right"):
		camera_pos += 1
		move_camera()

func move_camera():
	
	var tween := create_tween()
	
	if camera_pos > position_nodes.size() - 1:
		camera_pos = 0
	elif camera_pos < 0:
		camera_pos = position_nodes.size() - 1
	
	new_position = position_nodes[camera_pos]
	
	tween.tween_property(camera,"translation", new_position.translation, 1)
	tween.parallel().tween_property(camera,"rotation_degrees", new_position.rotation_degrees, 1)
