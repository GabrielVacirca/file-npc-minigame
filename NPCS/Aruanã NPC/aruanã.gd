extends Node2D

@onready var texture: AnimatedSprite2D = $texture

var hud_scene = preload("res://NPCS/HUD_NPC/hud_npcs.tscn")
var player_in_area: bool = false
var esperando_resposta = false
var dialog = [
	"Cauê: O rio está diferente, tudo ultimamente parece estar diferente, as coisas não são mais como antes, o que aconteceu Mestre?",
	"Aruanã: Cauê olhe o que aquela maldita empresa fez com o nosso rio, por favor meu Hèrèrawo (menino no dialeto Javaé), não deixe que acabem com a água do nosso povo!",
	"Cauê: O que eu posso fazer mestre? Não tenho força para combater a Ecoimpério!",
	"Aruanã: E nem precisa, coisas pequenas em conjunto movem coisas grandes. Comece com o seu pequeno barquinho a recolher o lixo do rio.",
	"Cauê: Ok, com os conhecimentos que tenho vou fazer algo que ajude meu povo!",
	"Aruanã: Mas, muito cuidado! Ao acidentalmente capturar peixes ao invés de lixo, você vai causar uma perda irreparável para o nosso ambiente.",
	"Cauê: Eu vou conseguir, fique tranquilo!"
]
var i_animating = false
var dialog_i = 0
var is_animating_text = false
var mission_accepted = false
var mission_declined = false

func _ready():
	texture.play("idle")
	hud.show_dialog_ui(false)
	add_to_group("Player")
	# Conectando o sinal da HUD ao NPC
	hud.choice_made.connect(on_choice_made)
	

func _unhandled_input(_event):
	if player_in_area and Input.is_action_just_pressed("falar") and not i_animating:
		if esperando_resposta or mission_declined:
			return

		if is_animating_text:
			hud.get_label().text = dialog[dialog_i]
			is_animating_text = false
			return

		# Ao chegar no índice 4, exibir botões de escolha
		if dialog_i == 4 and not mission_accepted:
			show_choice()
			return

		if dialog_i < dialog.size():
			i_animating = true
			hud.show_dialog_ui(true)
			await animate_text(dialog[dialog_i], hud.get_label())
			dialog_i += 1
			i_animating = false

		if dialog_i == dialog.size():
			hud.show_dialog_ui(false)
			player_in_area = false
			dialog_i = 0

func animate_text(full_text: String, label_node: Label, speed := 0.05) -> void:
	label_node.text = ""
	is_animating_text = true
	for i in range(full_text.length()):
		label_node.text += full_text[i]
		await get_tree().create_timer(speed).timeout
	is_animating_text = false

func show_choice():
	esperando_resposta = true
	hud.get_label().text = "Você aceita esta missão?"
	hud.show_yes_no_buttons(true)

func on_choice_made(result: bool):
	hud.show_yes_no_buttons(false)
	esperando_resposta = false

	if result:
		mission_accepted = true
		dialog_i = 4  # Continua com: Cauê: Ok, com os conhecimentos que tenho...
	else:
		mission_declined = true
		hud.get_label().text = "Aruanã: Que pena... nosso povo precisa de cada ajuda possível."
		await animate_text(hud.get_label().text, hud.get_label())
		await get_tree().create_timer(1.0).timeout
		hud.show_dialog_ui(false)
		player_in_area = false
		dialog_i = 0
		mission_declined = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = true
		dialog_i = 0
		hud.show_dialog_ui(true)
		hud.get_label().text = "Pressione 'E' para falar"

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false
		hud.show_dialog_ui(false)
		hud.get_label().text = ""
