extends KinematicBody

const GRAVITY := -300.0

export var speed := 700.0
export var jump_force := 3000.0


onready var floor_raycast = $FloorRayCast


var rotation_speed := 5.0

var velocity := Vector3.ZERO

func _physics_process(delta):
	
	if not floor_raycast.is_colliding():
		velocity.y += GRAVITY * delta
	
	get_inpt(delta)
	
	if Input.is_action_pressed("ui_jump") and floor_raycast.is_colliding():
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
