extends Camera2D
# Originally developed by Squirrel Eiserloh (http://youtu.be/tu-Qe66AvtY
#Refined by KidsCanCode (http://kidscancode.org/godot_recipes/2d/screen_shake/)

export var decay = 0.8
export var max_offest = Vector2(100,50)
export var max_roll = 0.1
export (NodePath) var target 

var trauma = 0.0
var trauma_power = 2
var max_trauma = 4.0
onready var noise = OpenSimplexNoise.new()
var noise_y = 0
func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2


func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func shake():
	var amount = pow(min(trauma,1.0), trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offest.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offest.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
	print(trauma)

func add_trauma(amount):
	trauma = min(trauma + amount, max_trauma)
