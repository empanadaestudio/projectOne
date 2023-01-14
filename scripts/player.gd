extends KinematicBody



const GRAVITY := -300.0           #Constante de gravedad

#Variables para el inspector
export var speed := 800.0                #Velocidad del jugador
export var jump_force := 3000.0          #Fuerza del salto del jugador
export var rotation_speed := 7.0         #Velocidad de rotacion del jugador

#Nodos
onready var interaction = $interaction     #Raycast para saber si puede interactuar
onready var hand = $hand                   #Posision de las manos

#Otras variables
var prev_collider
var picked_object

var velocity := Vector3.ZERO      #Vector de velocidad

func _physics_process(delta):
	
	#Si no esta en el suelo se le aplica gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	#Collider obtiene el valor el Area con el que colisiona el raycast
	var collider = interaction.get_collider()
	
	#Funcion donde se colocan todo tipo de inputs 
	get_inpt(delta)
	
	
	#Aplicar movimiento
	velocity = move_and_slide(velocity, Vector3.UP)
	
	##############PARA PICKUP#################
	if picked_object:
		var tween := create_tween()
		tween.tween_property(picked_object, "global_translation", hand.global_translation, 0.1)
		
	
		####VISIBILIDAD DEL SHADER####
	if collider:
		if collider.get_parent().is_in_group("box"):
			collider.get_node("shader").visible = true
	else:
		if prev_collider:
			if prev_collider.get_parent().is_in_group("box"):
				prev_collider.get_node("shader").visible = false
	
	
	prev_collider = collider
	##########################################



func get_inpt(delta):
	
	#Guarda la velocidad en y 
	var vy = velocity.y
	
	#Setear velocity a Vector3.ZERO
	velocity = Vector3.ZERO
	
	#vector de direccion
	var move_direction := Vector3.ZERO
	
	#Axis para rotar, devuelve -1, 0, 1
	move_direction.x = Input.get_axis("ui_left", "ui_right")
	
	#Axis para moverse, devuelve -1, 0, 1
	move_direction.z = Input.get_axis("ui_down", "ui_up")
	
	#Aplicando velocidad con move_direction.z de forma local
	if move_direction.z:
		velocity += transform.basis.z * speed * move_direction.z * delta
	
	#Rotar al player 
	rotate_y(rotation_speed * delta * -move_direction.x)
	
	#Normalizar el vector de direccion
	move_direction.normalized()
	
	#Aplicar velocidad en y guardada previamente
	velocity.y = vy
	
	#Salta si se aprieta su tecla y esta en el suelo
	if Input.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_force * delta
	
	##############PARA PICKUP##############
	if Input.is_action_just_pressed("left_mouse_click"):
		if picked_object:
			drop_object()
		else:
			pick_object()
	#######################################


func pick_object():
	var collider = interaction.get_collider()
	if collider and collider.get_parent() is RigidBody:
		picked_object = collider.get_parent()
		
		picked_object.mode = RigidBody.MODE_KINEMATIC
		

func drop_object():
	picked_object.mode = RigidBody.MODE_RIGID
	
	picked_object = null


func _on_Area_area_entered(area):
	if area.is_in_group("goal"):
		print(area.get_parent().level_passed)
#		if area.level_passed:
#			if Input.is_action_just_pressed("left_mouse_click"):
#				print("ganaste")
