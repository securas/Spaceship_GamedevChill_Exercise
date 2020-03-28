extends Particles2D

func _input(event):
	if event.is_action_pressed("btn_mouse"):
		process_material.set_shader_param( "target", get_global_mouse_position() )