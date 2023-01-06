extends Camera

var rotation_speed := 1

var position_x := 0.0
var position_z := 0.0

var angle := 0.0
var radio := 20 

export(float) var max_radio := 50

func _process(delta):
	transform.origin.x = cos(deg2rad(angle)) * radio
	transform.origin.z = sin(deg2rad(angle)) * radio
	
	var input = Input.get_axis("ui_camera_left", "ui_camera_right")
	
	angle += 1 * -input
	radio = clamp(radio, -max_radio, max_radio)

func _unhandled_input(event):
	
	if event.is_action_pressed("ui_change_mouse_mode"):
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			print(Input.mouse_mode)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * .1))
		elif event is InputEventMouseButton:
			if event.button_index == BUTTON_WHEEL_DOWN:
				radio += 1
			elif event.button_index == BUTTON_WHEEL_UP:
				radio -= 1
