extends Node
@onready var text_label = $"../Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/RichTextLabel"

#var Tamanho: int
#var numero_de_testes: int # Para testar n vezes
const X = 4

var	set_direto = 0
var	set_direto_array = 0
var get_direto = 0
var	get_direto_array = 0
#Para um teste mais apurado como usaremos tambem Vector4 seria bom o tamanho ter um multiplo de 4 como tamanho




func _start(Tamanho: int, numero_de_testes: int):
	var Tamanho_final = Tamanho * X

	text_label.append_text("O numero de apurações é de "+ str(Tamanho_final)+"\n")
	var teste = 0
	for n in range(numero_de_testes):
		teste += 1
		await _teste(Tamanho_final, teste)
		
	text_label.append_text("Valores finais em ms, apos "+str(numero_de_testes)+" testes com tamanho total "+str(Tamanho_final) +" para

	set direto "+ str(set_direto)+" com media de "+ str(set_direto/numero_de_testes)+"
	set direto em um array "+ str(set_direto_array)+" com media de "+ str(set_direto_array/numero_de_testes)+"

	get_direto "+ str(get_direto)+" com media de "+ str(get_direto/numero_de_testes)+"
	get_direto em um array "+ str(get_direto_array)+" com media de "+ str(get_direto/numero_de_testes)
	)
	text_label.append_text("
	
	O teste em Vector será o mais diferente pois eles são os unicos que possuem tamanho imutavel,
	isso pode gerar alguns problemas com a equivalencia dele com as outras estruturas
	Foi se usado 		
	if i%4 == 0:
		vec.x = i
	elif i%4 == 1:
		vec.y = i
	elif i%4 == 2:
		vec.z = i
	else:
		vec.w = i
	Para manter a sequencia dentro dos array (n, n+1, n+2, n+3)
	Isso concerteza afeta a performance"
	)

func _teste(N: int, teste: int) -> void:
	var vec: Vector4

	#Set Direto
	var start = Time.get_ticks_msec()
	for i in range(N):
		if i%4 == 0:
			vec.x = i
		elif i%4 == 1:
			vec.y = i
		elif i%4 == 2:
			vec.z = i
		else:
			vec.w = i
	var end = Time.get_ticks_msec()
	text_label.append_text("Teste set_direto levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	set_direto += (end - start)
	
	#Set Direto com Vectors dentro de um array
	var array: Array = []
	var aux
	array.resize(ceili(N/4.0))
	start = Time.get_ticks_msec()
	
	aux = floori(N/4.0)
	for n in range(aux):
		for i in range(4):  # Agora percorremos apenas 4 iterações para X, Y, Z, W
			if i == 0:
				vec.x = n * 4 + i
			elif i == 1:
				vec.y = n * 4 + i
			elif i == 2:
				vec.z = n * 4 + i
			elif i == 3:
				vec.w = n * 4 + i
		array[n] = vec
	end = Time.get_ticks_msec()
	text_label.append_text("Teste set_direto_array levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	set_direto_array += (end - start)
	
	#Get direto
	vec = Vector4(0, 1, 2, 3)
	var M: int
	
	
	start = Time.get_ticks_msec()
	
	for i in range(N):
		if i%4 == 0:
			M = vec.x
		elif i%4 == 1:
			M = vec.y
		elif i%4 == 2:
			M = vec.z
		else:
			M = vec.w
			
	end = Time.get_ticks_msec()
	text_label.append_text("Teste get_direto levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	get_direto += (end - start)
	
	#Get direto de um array de vec4
	var nomeArray: Array = []
	start = Time.get_ticks_msec()

	nomeArray.resize(array.size() * 4)  # Ajustando o tamanho corretamente

	# Extraindo os valores do array de Vector4
	for n in range(array.size()):
		#var vec4 = array[n]
		nomeArray[n * 4] = vec.x
		nomeArray[n * 4 + 1] = vec.y
		nomeArray[n * 4 + 2] = vec.z
		nomeArray[n * 4 + 3] = vec.w
	end = Time.get_ticks_msec()
	text_label.append_text("Teste get_direto_array levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	get_direto_array += (end - start)
	await get_tree().process_frame
