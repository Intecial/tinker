extends Panel
class_name GearDetails

@onready var nameLabel : RichTextLabel = $VBoxContainer/MarginContainer2/RichTextLabel
@onready var descriptionLabel : RichTextLabel = $VBoxContainer/MarginContainer/RichTextLabel
	
func _ready() -> void:
	await get_tree().process_frame
	for gearArrSlot : GearArraySlot in Constant.GEAR_INVENTORY.get_children():
		gearArrSlot.onHovered.connect(showDetails)
		gearArrSlot.onExit.connect(clearDetails)
	
	for gearArrSlot : GearArraySlot in Constant.GEAR_ARRAY.get_children():
		gearArrSlot.onHovered.connect(showDetails)
		gearArrSlot.onExit.connect(clearDetails)
	
	for gearArrSlot : GearArraySlot in Constant.SHOP_ARRAY.get_children():
		gearArrSlot.onHovered.connect(showDetails)
		gearArrSlot.onExit.connect(clearDetails)
	
func showDetails(gear_array_slot: GearArraySlot) -> void:
	if(gear_array_slot.gear == null):
		return
	nameLabel.text = gear_array_slot.gear.gearName
	if gear_array_slot.isShop:
		nameLabel.text += "[indent]$" + str(gear_array_slot.gear.buyValue)
	descriptionLabel.text = gear_array_slot.gear.description
	

func clearDetails() -> void:
	nameLabel.text = ""
	descriptionLabel.text = ""
