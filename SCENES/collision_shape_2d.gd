extends CollisionShape2D

const Speed = 60 
var direction = 1
@onready var ray_castright_right: RayCast2D = $"../../RayCastrightRIGHT"
@onready var ray_castright_2left: RayCast2D = $"../../RayCastright2LEFT"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if ray_castright_right.is_colliding():
		direction = -1
	if ray_castright_2left.is_colliding():
		direction = 1
	position.x += Speed * delta 
	
	
