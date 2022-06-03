extends Node

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

var current_ammo = clip_size
var ready_to_fire = true
var reloading = false

func _process(delta):
	if Input.is_action_just_pressed("primary_fire") and ready_to_fire:
		
		if current_ammo > 0 and not reloading:
			print("FIRE!")
			
			ready_to_fire = false
			
			current_ammo -= 1
			yield(get_tree().create_timer(fire_rate),"timeout")

			ready_to_fire = true
			
		elif not reloading:
			print("Reloading")
			reloading = true
			yield(get_tree().create_timer(reload_rate), "timeout")
			current_ammo = clip_size
			reloading = false
			print("Done")
			
