extends Panel
class_name GearDetails

@onready var nameLabel : RichTextLabel = $VBoxContainer/MarginContainer2/HBoxContainer/PanelContainer/Name
@onready var descriptionLabel : RichTextLabel = $VBoxContainer/MarginContainer/Desc
@onready var priceLabel: RichTextLabel = $VBoxContainer/MarginContainer2/HBoxContainer/PanelContainer2/Price
@onready var permanentLabel: PanelContainer = $VBoxContainer/MarginContainer2/HBoxContainer/PanelContainer3

func _ready() -> void:
	await get_tree().process_frame
	for gearArrSlot : GearArraySlot in Constant.GEAR_INVENTORY.inventory:
		gearArrSlot.onHovered.connect(showDetails)
		gearArrSlot.onExit.connect(clearDetails)
	
	for gearArrSlot : GearArraySlot in Constant.GEAR_ARRAY.get_children():
		gearArrSlot.onHovered.connect(showDetails)
		gearArrSlot.onExit.connect(clearDetails)
	
	for gearArrSlot : GearArraySlot in Constant.SHOP_ARRAY.get_children():
		gearArrSlot.onHovered.connect(showDetails)
		gearArrSlot.onExit.connect(clearDetails)
	
	var enemyPanel: EnemyPanel = Constant.PANEL_MANAGER.getPanel("Enemy")
	enemyPanel.gearSlot.onHovered.connect(showDetails)
	enemyPanel.gearSlot.onExit.connect(clearDetails)
	
	
func showDetails(gear_array_slot: GearArraySlot) -> void:
	if(gear_array_slot.gear == null):
		return
	nameLabel.text = gear_array_slot.gear.gearName
	if gear_array_slot.isShop:
		priceLabel.text += "$"+str(gear_array_slot.gear.buyValue)
	descriptionLabel.text = gear_array_slot.gear.description
	if gear_array_slot.gear.isConsumable:
		permanentLabel.visible = false
	else:
		permanentLabel.visible = true
		
	

func clearDetails() -> void:
	nameLabel.text = ""
	descriptionLabel.text = ""
	permanentLabel.visible = false
	priceLabel.text = ""
