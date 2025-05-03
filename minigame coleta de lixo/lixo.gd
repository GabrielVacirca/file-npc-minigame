extends Area2D
 
var coletado := false  # saber se o lixo foi coletado






#quando o player tenta coletar o lix
func coletar():
	#vai verificar se o lixo foi coletado
	if not coletado:
		coletado = true #marca o lixo como coletado para impedir que ele seja coletado dnv
		print("lixo coletadoo")
		$Sprite2D.visible = false #o sprite some da tela
		$CollisionShape2D.set_deferred("disabled", true) #desativa a colisao do lixo
		queue_free() # remove o sprite do lixo
