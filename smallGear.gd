extends Gear
class_name SmallGear

@export var curve: Curve


func canBuild(tile: Tile) -> bool:
	if (tile.occupied):
		return false
	return true
	


func occupy(tile: Tile) -> bool:
	if !canBuild(tile):
		return false;
	
	tile.occupied = true
	tile.occupant = self
	return true


#func evaluate(speed: float = self.rotateSpeed, power: float = self.startingPower):
	