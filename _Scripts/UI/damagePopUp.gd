extends Panel
class_name DamagePopUp

@onready var dmg_label: RichTextLabel = $RichTextLabel
func set_damage_text(amount: int, front: String) -> void:
	dmg_label.text = "Test?"
	if dmg_label:
		dmg_label.text = front + str(amount)
