extends CanvasGroup

@onready var label: Label = $Control/Label
@onready var back: ColorRect = $Control/back
@onready var choice_buttons: HBoxContainer = $Control/ChoiceButtons
@onready var yes_button: Button = $Control/ChoiceButtons/YesButton
@onready var no_button: Button = $Control/ChoiceButtons/NoButton

signal choice_made(result: bool)

func _ready():
	show_yes_no_buttons(false)  # Garante que os botões estão ocultos inicialmente
	yes_button.pressed.connect(_on_yes_button_pressed)
	no_button.pressed.connect(_on_no_button_pressed)

func show_dialog_ui(visible: bool):
	label.visible = visible  # Torna a caixa de diálogo visível ou invisível
	back.visible = visible   # Torna o fundo da caixa de diálogo visível ou invisível

func get_label() -> Label:
	return label  # Retorna o label da caixa de diálogo para facilitar o acesso

func show_yes_no_buttons(visible: bool):
	choice_buttons.visible = visible  # Torna os botões de "Sim"/"Não" visíveis ou invisíveis

# Quando o jogador escolhe "Sim"
func _on_yes_button_pressed():
	show_yes_no_buttons(false)  # Esconde os botões
	emit_signal("choice_made", true)  # Emite o sinal para indicar que "Sim" foi escolhido

# Quando o jogador escolhe "Não"
func _on_no_button_pressed():
	show_yes_no_buttons(false)  # Esconde os botões
	emit_signal("choice_made", false)  # Emite o sinal para indicar que "Não" foi escolhido
