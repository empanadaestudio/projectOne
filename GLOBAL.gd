extends Node

#### PUZZLE BOTONES ####
var boton1_pressed = false
var boton2_pressed = false
var boton3_pressed = false
#### #### #### #### ####

var max_load_time = 10000

func goto_scene(path, curr_scene) -> void:
	var loader = ResourceLoader.load_interactive(path)
	
	if loader == null:
		print("falla en loader = null")
		return
	
	var loading_bar = load("res://GUI Scenes/loading_bar.tscn").instance()
	
	get_tree().get_root().call_deferred('add_child', loading_bar)
	
	var t = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() - t < max_load_time:
		var err = loader.poll()
		
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			
			curr_scene.queue_free()
			loading_bar.queue_free()
			get_tree().get_root().call_deferred('add_child', resource.instance())
			break
		elif err == OK:
			var progress = float(loader.get_stage()) / loader.get_stage_count()
			loading_bar.get_node("progress_bar").value = progress * 100
		else:
			print("error al cargar el archivo")
			break
	
	yield(get_tree(), "idle_frame")
