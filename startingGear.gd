extends Gear
class_name StartingGear

var occupiedTile : Tile = null

func canBuild(tile: Tile) -> bool:
	if (tile.occupied):
		return false
	return true
	


func occupy(tile: Tile) -> bool:
	if !canBuild(tile):
		return false;
	tile.occupied = true
	tile.occupant = self
	self.occupiedTile = tile
	return true
	
func evaluate(speed: float = self.rotateSpeed, power: float = self.startingPower):
	var neighbors := occupiedTile.gridManager.getNeighbours(occupiedTile)
	var occupiedNeighbors = neighbors.filter(func(ea): return ea.occupied)
	for gearedTile in occupiedNeighbors:
		if (gearedTile.occupant is Gear):
			var gear : Gear = gearedTile.occupant
			gear.evaluate(speed, power)
			gear.isClockwise = !gear.isClockwise
			
	
