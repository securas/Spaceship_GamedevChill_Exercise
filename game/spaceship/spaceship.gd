extends KinematicBody2D

const MAX_VEL = 200.0
const ACCEL = 10.0
var vel := Vector2.ZERO

enum HIT_STATES { NORMAL, HIT }
var state = HIT_STATES.NORMAL
var hit_timer := 0.0

func _physics_process(delta):
	
	match state:
		HIT_STATES.NORMAL:
			var dir := Vector2( \
				Input.get_action_strength( "btn_right" ) - Input.get_action_strength( "btn_left" ), \
				Input.get_action_strength( "btn_down" ) - Input.get_action_strength( "btn_up" ) )
			if dir.length() > 0.1:
				dir = dir.normalized()
				vel = vel.linear_interpolate( MAX_VEL * dir, ACCEL * delta )
			else:
				vel = vel.linear_interpolate( Vector2.ZERO, ACCEL * delta )
			var collision = move_and_collide( vel * delta )
			if collision:
				var motion = collision.remainder.bounce( collision.normal )
				vel = vel.bounce( collision.normal ) * 1.5
				var _ret = move_and_collide( motion )
				state = HIT_STATES.HIT
				hit_timer = 0.2
				$anim.play("hit")
		HIT_STATES.HIT:
			hit_timer -= delta
			if hit_timer <= 0:
				state = HIT_STATES.NORMAL
				$anim.play("normal")
			var collision = move_and_collide( vel * delta )
			if collision:
				var motion = collision.remainder.bounce( collision.normal )
				vel = vel.bounce( collision.normal ) * 1.0#0.9
				var _ret = move_and_collide( motion )
				state = HIT_STATES.HIT
				hit_timer = 0.2
			
			