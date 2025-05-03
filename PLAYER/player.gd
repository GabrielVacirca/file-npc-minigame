extends Node2D

# Velocidade de movimento do personagem
const SPEED = 200

# Direção do movimento atual
var direction := Vector2.ZERO

# Acessa a sprite animada (certifique-se que o nome está certo)
@onready var sprite := $Player
@export var seed_scene: PackedScene	


func _process(delta):
	# Reseta direção
	direction = Vector2.ZERO

	# Checa as teclas pressionadas
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1

	elif  Input.is_action_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normaliza a direção para que diagonal não seja mais rápida
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		position += direction * SPEED * delta
		update_animation()
	
func _unhandled_input(event: InputEvent) -> void: 
	#verifica se foi pressionado a tecla
	if event.is_action_pressed("coletar"):
		# se foi pressionada, chama a funcao que verifica se tem lixo
		var lixo = get_overlapping_lixo()
		print("encontramos o lixo")
		# se tiver lixo, chama a funcao coletar, que esta na cena do lixo
		if lixo:
			print("chamar coloeta do lixo")
			lixo.coletar()
	







	

#essa funcao vai verificar se tem algum objeto do grupo que coloquei ''lixo'', colidino com o detector
func get_overlapping_lixo():  
	# pega todas as areas que estao meio que sobrepondo o nó chama lixo_detector
	var areas = $lixo_detector.get_overlapping_areas()
	#percorre cada area detectada
	for area in areas:
		#verifica se area existe e se pertence o grupo lixo que foi criado
		if area and area.is_in_group("lixo"):
			#se encontrar retorna a area 
			return area
	#se nao encontrar nenhum lixo, retorna como null (nao foi detectado nenhum lixo)
	return null	
		
	
		
		




func update_animation():
	# Troca a animação com base na direção do movimento
	if direction.x > 0:
		sprite.play("walk_d")
	elif direction.x < 0:
		sprite.play("walk_e")
	elif direction.y > 0:
		sprite.play("walk_n")
	elif direction.y < 0:
		sprite.play("walk_s")
