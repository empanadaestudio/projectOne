extends KinematicBody


const GRAVITY := -100.0           #Constante de gravedad

signal player_death


#Variables para el inspector
export var speed := 600.0             #Velocidad del jugador
export var jump_force := 1500.0       #Fuerza del salto del jugador
export var rotation_speed := 6.0      #Velocidad de rotacion del jugador
export var initial_time := 120         #Tiempo de vida en segundos

#Nodos
onready var interaction : RayCast = $interaction        #Raycast para saber si puede interactuar
onready var hand : Position3D = $hand                   #Posision de las manos
onready var anim_player : AnimationPlayer = $modelo/AnimationPlayer

#Otras variables
var prev_collider
var picked_object
var pull_power := 10

var velocity := Vector3.ZERO      #Vector de velocidad
var snap_vector := Vector3.DOWN   #Vector del suelo

var life_time = initial_time

func _ready():
	update_health()

func update_health():
	$"%LifeTime".text = str(life_time/60) + " : " + str(life_time%60)

func _physics_process(delta):
	
	#Si no esta en el suelo se le aplica gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	#Control de movimiento con laderas
	move_control(delta)
	pick_control()
	

func pick_control():
	
	#Collider obtendra el valor del BODY con el que colisione el raycast "interaction"
	#Si y solo si existe un body y esta en el grupo "pickeable"
	var collider = interaction.get_collider()
	
	if picked_object:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		if b.distance_to(a) < 5:
			picked_object.set_linear_velocity((b-a) * pull_power)
		else:
			drop_object()
	
	if collider is RigidBody:
		collider.find_node("shader").visible = true
		
	else:
		if prev_collider is RigidBody:
			prev_collider.find_node("shader").visible = false
	
	prev_collider = collider
	

func move_control(delta):
	#Guarda la velocidad en y 
	var vy = velocity.y
	
	var just_landed := is_on_floor() and snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_pressed("ui_jump")
	
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
		#$AnimationPlayer.play("walk")
	
	anim_player.play("ArmatureAction")
	
	#Rotar al player 
	rotate_y(rotation_speed * delta * -move_direction.x)
	
	#Normalizar el vector de direccion
	move_direction.normalized()
	
	#Aplicar velocidad en y guardada previamente
	velocity.y = vy
	
	#Salta si se aprieta su tecla y esta en el suelo
	if is_jumping:
		velocity.y = jump_force * delta
		snap_vector = Vector3.ZERO
	elif just_landed:
		snap_vector = Vector3.DOWN
	
	#Aplicar movimiento
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true, 2)

func _unhandled_input(event):
	if event.is_action_pressed("left_mouse_click"):
		interact()

func interact():
	var collider = interaction.get_collider() 
	
	if picked_object:
		drop_object()
	
	if collider:
		if collider.is_in_group("pickeable"):
			if picked_object:
				drop_object()
			else:
				picked_object = collider
		elif collider is LeverClass:
			collider.active()
			
			print(collider.on)

func drop_object():
	picked_object = null

func _on_Timer_timeout():
	life_time -= 1
	update_health()
	if life_time == 0:
		emit_signal("player_death")
