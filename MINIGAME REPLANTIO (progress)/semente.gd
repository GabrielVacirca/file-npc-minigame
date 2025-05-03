extends Area2D

@export var grow_time := 5.0 # tempo pra crescer

var time := 0.0   # vai guardar o tempo quando a semente foi plantada
var grow := true # mostra se ainda ta crescendo

func _process(delta):
	if grow: # se ainda ta crescendo
		time += delta      # somo o tempo desde o ultimo frame ao timer
		if time >= grow_time:  # quando for maior ou igual que o tempo do crescimento 
			_grow()  # ativa essa função e cresce a semente mudando para png

#troca aparencia da semente, mostra que cresceu
func _grow():     
	
	grow = false   # atualiza pra mostrar que a planta n cresce
	
