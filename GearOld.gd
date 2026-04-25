extends Node3D
class_name GearOld

@export var rotateSpeed := 2.0
@export var startingPower := 5.0
@export var isClockwise := true

func _process(delta: float) -> void:
	var rotationSpeed := rotateSpeed * delta
	if (!isClockwise):
		rotationSpeed = rotationSpeed * -1
	self.rotate_y(rotationSpeed)
	
func getOccupiedNeighbours() -> Array[Tile]:
	return []
	
func canBuild(tile: Tile) -> bool:
	return true
	
func occupy(tile: Tile)-> bool:
	return true
	

func evaluate(speed: float = self.rotateSpeed, power: float = self.startingPower):
	return 