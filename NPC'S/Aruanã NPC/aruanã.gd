extends Node2D


@onready var texture: AnimatedSprite2D = $texture


var hud_scene = preload("res://NPC'S/HUD_NPC/hud_npc's.tscn")
var player_in_area: bool = false   #quando o player entrar na area a mensagem vai estar invísivel
var dialog = [       #array para dialogo [ escrever as coisas por aqui]
	"Olá, tudo bem?",
	
]
#animacao dialogo e bla bla
var i_animating = false
var dialog_i = 0

func _ready():
	texture.play("idle")
	hud.show_dialog_ui(false)	
	add_to_group("Player")

	



func _unhandled_input(_event):
	if player_in_area and Input.is_action_just_pressed("falar") and not i_animating:
		if dialog_i < dialog.size(): # verifica se tem falas no array
			i_animating = true
			hud.show_dialog_ui(true)
			
			await animate_text(dialog[dialog_i], hud.get_label())  #mostra a fala
			dialog_i += 1 #se tiver mais falas no array, vai avançar no clique
			i_animating = false
		
		else: # se chega no final e
			hud.show_dialog_ui(false)
			dialog_i = 0 #reseta o label e comeca tudo denovo
			
			
			
			
			
			
		

func animate_text(full_text: String, label_node: Label, speed := 0.05) -> void: #animação do texto
	label_node.text = "" #vai limpar o texto do label antes de começar a animação
	for i in range(full_text.length()): #loop que vai percorrer cad aletra
		label_node.text += full_text[i] #adiciona uma letra ao texto da caixa de dialogo
		await get_tree().create_timer(speed).timeout #espera o tempo antes de mostrar a próxima letra
		


	



	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Oi")
	if body.name == "Player":
		player_in_area = true              # 1. Marca que o player está na área
		dialog_i = 0                       # 2. Reseta o diálogo (pra começar do início)
		hud.show_dialog_ui(true)          # 3. Exibe a caixa de diálogo na tela
		hud.get_label().text = "Pressione 'E' para falar"  # 4. Mostra o texto inicial
		
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false                        # 1. Marca que o player saiu da área
		hud.show_dialog_ui(false)                     # 2. Esconde a caixa de diálogo
		hud.get_label().text = ""                     # 3. Limpa o texto da caixa de diálogo
