extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#If the OS is not Android or iOS, remove the inputs.
	if OS.get_name() != "Android" or OS.get_name() != "iOS":
		queue_free()
		pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
