extends Control
class_name GearArray

var assignedGears : Array[GearResource] = [] 
@export var gear_slots: Array[GearArraySlot] = []

var is_hovered: bool = false
var closest_slot: GearArraySlot = null

signal closest_gear_changed(slot: GearArraySlot)

func _enter_tree() -> void:
	Constant.GEAR_ARRAY = self

func _ready() -> void:
	for gearSlot: GearArraySlot in gear_slots:
		gearSlot.spinContent = true
		gearSlot.onGearSet.connect(onGearArrayChange)
		gearSlot.onGearRemoved.connect(onGearArrayChange)

func _exit_tree() -> void:
	for gearSlot: GearArraySlot in gear_slots:
		gearSlot.onGearSet.disconnect(onGearArrayChange)
		gearSlot.onGearRemoved.disconnect(onGearArrayChange)
	
func disableArraySlots() -> void:
	for gearArraySlot: GearArraySlot in gear_slots:
		gearArraySlot.disableSlot()

func enableArraySlots() -> void:
	for gearArraySlot: GearArraySlot in gear_slots:
		gearArraySlot.enableSlot()

func resolveGears() -> void:
	for gearArrSlot: GearArraySlot in gear_slots:
		if gearArrSlot.gear != null and Constant.PLAYER.target:
			gearArrSlot.screenShake()
			gearArrSlot.explode()
			await Constant.PLAYER.perform_gear(gearArrSlot.gear)
#			await gearArrSlot.gear.evaluate(player)
			if gearArrSlot.gear.isConsumable:
				Constant.PLAYER.gear_pouch.discard(gearArrSlot.gear)
				gearArrSlot.removeGear()
				# Put in gear_pouch
		if Constant.PLAYER.target == null:
			return

func onGearArrayChange(gear: GearArraySlot) -> void:
	pass
#	print(gear.name)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		print(closest_slot)

func _process(_delta: float) -> void:
	if not is_hovered:
		return
	_update_closest_slot()

func _update_closest_slot() -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	var new_closest: GearArraySlot = null
	var closest_dist : float = INF
	for slot: GearArraySlot in gear_slots:
		var d : float = mouse_pos.distance_squared_to(slot.get_global_rect().get_center())
		if d < closest_dist:
			closest_dist = d
			new_closest = slot
	if new_closest != closest_slot:
		closest_slot = new_closest
		closest_gear_changed.emit(closest_slot)

func _on_mouse_exited() -> void:
	is_hovered = false
	closest_slot = null
	closest_gear_changed.emit(null)

func _on_mouse_entered() -> void:
	is_hovered = true
