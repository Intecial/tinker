extends GamePanel
class_name ForgePanel


@onready var firstGearSlot: GearArraySlot = $HBoxContainer2/HBoxContainer/FirstGear
@onready var secondGearSlot: GearArraySlot = $HBoxContainer2/HBoxContainer/SecondGear
@onready var resultGear: GearArraySlot = $HBoxContainer2/HBoxContainer/Result

#func _enter_tree() -> void:
#	Constant.FORGE_PANEL = self
	
func onForgeClick() -> void:
	var forgedGear: GearResource = forge(firstGearSlot.gear, secondGearSlot.gear)
	if forgedGear:
		await get_tree().process_frame
		resultGear.setGear(forgedGear)
		resultGear.explode()
		firstGearSlot.explode()
		firstGearSlot.setGear(null)
		secondGearSlot.explode()
		secondGearSlot.setGear(null)
		resultGear.screenShake()
	
func forge(firstGear: GearResource, secondGear: GearResource) -> GearResource:
	var forgedGear : GearResource = GearResource.new()
	if firstGear.isMerged or secondGear.isMerged:
		return null
	if !firstGear or !secondGear:
		return null
	if firstGear.isConsumable != secondGear.isConsumable:
		return null
	forgedGear.gearName = firstGear.gearName + " + " + secondGear.gearName
	forgedGear.gearType = firstGear.gearType
	forgedGear.icon = firstGear.icon
	forgedGear.actions = firstGear.actions + secondGear.actions
	forgedGear.color = firstGear.color + secondGear.color
	forgedGear.isConsumable = false
	forgedGear.sellValue = firstGear.sellValue + secondGear.sellValue
	forgedGear.description = firstGear.description + " \n " + secondGear.description
	forgedGear.isMerged = true
	return forgedGear
