extends CanvasGroup

@onready var label: Label = $Control/Label
@onready var back: ColorRect = $Control/back

func show_dialog_ui(visible: bool):
	label.visible = visible
	back.visible = visible

func get_label() -> Label:
	return label
