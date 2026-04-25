extends Gear
class_name BigGear

@export var curve: Curve

func canBuild(tile: Tile) -> bool:
	var neighbors: = tile.gridManager.getNeighbours(tile)
	neighbors = neighbors.filter(func(ea): return (ea.occupied and !(ea.occupant is BigGear)))
	print(neighbors)
	if (tile.occupied):
		return false
	if (len(neighbors)):
		return false
	return true

func occupy(tile: Tile) -> bool:
	if !canBuild(tile):
		return false;
	
	tile.occupied = true
	tile.occupant = self
	var neighbors: = tile.gridManager.getNeighbours(tile)
	for neighbor in neighbors:
		neighbor.occupied = true
		neighbor.occupant = self
	return true