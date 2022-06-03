extends Spatial

onready var AniPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func Shoot():
	if AniPlayer.is_playing():
		pass
	else:
		AniPlayer.play("Fire")
	
