extends Node
class_name GearPouch

var ready_gears: Array[GearResource] = []
var discarded_gears: Array[GearResource] = []

func _ready() -> void:
	ready_gears.append(load("uid://dt1eu36i6lpyk"))
	ready_gears.append(load("uid://dt1eu36i6lpyk"))
	ready_gears.append(load("uid://dt1eu36i6lpyk"))
	ready_gears.append(load("uid://dt1eu36i6lpyk"))
	ready_gears.append(load("uid://dt1eu36i6lpyk"))
	
	ready_gears.append(load("uid://nonsbjkfwx4f"))
	ready_gears.append(load("uid://nonsbjkfwx4f"))
	ready_gears.append(load("uid://nonsbjkfwx4f"))
	ready_gears.append(load("uid://nonsbjkfwx4f"))
	ready_gears.append(load("uid://nonsbjkfwx4f"))
	ready_gears.shuffle()

func discard(gear: GearResource) -> void:
	discarded_gears.append(gear)
	
func shuffle() -> void:
	for gear: GearResource in discarded_gears:
		ready_gears.append(gear)
	ready_gears.shuffle()	

func draw() -> GearResource:
	if len(ready_gears):
		return ready_gears.pop_front()
	else:
		shuffle()
		return ready_gears.pop_front()