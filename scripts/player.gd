extends KinematicBody

const GRAVITY := -300.0

var speed := 500.0
var rotation_speed := 5.0
var jump_force := 3000.0

var velocity := Vector3.ZERO
var snap_vector := Vector3.DOWN

func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	
	get_inpt(delta)
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_force * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)
	

func get_inpt(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	
	var move_direction := Vector3.ZERO
	
	move_direction.x = Input.get_axis("ui_left", "ui_right")
	
	#move_direction.z devuelve -1, 0, 1 y determina si va hacia adelante o hacia atras
	move_direction.z = Input.get_axis("ui_down", "ui_up")
	
	if move_direction.z:
		velocity += transform.basis.z * speed * move_direction.z * delta
	
	rotate_y(rotation_speed * delta * -move_direction.x)
	
	move_direction.normalized()
	
	velocity.y = vy
