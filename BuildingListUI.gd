extends HBoxContainer
class_name BuildingListUI

@export var buildingList: BuildingList
@export var buildingManager: BuildingManager

func _ready() -> void:
	for packedScene in buildingList.list:
		print(packedScene)
		var newButton: Button = Button.new()
		print(packedScene.resource_path)
		newButton.text = packedScene.resource_path
		newButton.pressed.connect(func(): buildingManager.onSwitch(packedScene))
		self.add_child(newButton)
	
