extends Node
@onready var text_label = $"../Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/RichTextLabel"

#var Tamanho: int
#var numero_de_testes: int # Para testar n vezes
const X = 4

var append = 0
var find_key = 0
var busca_por_valor = 0
var has = 0
var modificacao_direta = 0
var get_direto = 0
var get_direto_array = 0
var erase = 0
var clear = 0
#Para um teste mais apurado como usaremos tambem Vector4 seria bom o tamanho ter um multiplo de 4 como tamanho

func _start(Tamanho: int, numero_de_testes: int):
	var Tamanho_final = Tamanho * X
	text_label.append_text("O numero de apurações é de "+ str(Tamanho_final)+"\n")
	text_label.scroll_to_line(text_label.get_line_count() - 1)
	var teste = 0
	for n in range(numero_de_testes):
		teste += 1
		await _teste_dicionario(Tamanho_final, teste)
		text_label.scroll_to_line(text_label.get_line_count() - 1)
		
	text_label.append_text("Valores finais em ms, apos "+str(numero_de_testes)+" testes com tamanho total "+str(Tamanho_final) +" para
	append "+ str(append)+" com media de "+ str(append/numero_de_testes)+"
	find_key "+ str(find_key)+" com media de "+ str(find_key/numero_de_testes)+ "
	busca por valor "+ str(busca_por_valor)+" com media de "+ str(busca_por_valor/numero_de_testes)+ "
	has "+ str(has)+" com media de "+ str(has/numero_de_testes)+ "
	modificação direta "+ str(modificacao_direta)+" com media de "+ str(modificacao_direta/numero_de_testes)+"
	sort não possui um equivalente real para dicionarios
	get_direto "+ str(get_direto)+" com media de "+ str(get_direto/numero_de_testes)+ "
	get_direto_array"+ str(get_direto_array)+ "com media de "+ str(get_direto_array/numero_de_testes)+"
	erase "+ str(erase)+" com media de "+ str(erase/numero_de_testes)+"
	--- Casos Espciais --- elementos sem loops
	clear "+ str(clear)+" com media de "+ str(clear/numero_de_testes)
	)
	text_label.scroll_to_line(text_label.get_line_count() - 1)

func _teste_dicionario(N: int, teste: int) -> void:
	# .append
	var dic: Dictionary = {}

	var start = Time.get_ticks_msec()
	
	for i in range(N):
		dic[i] = i 
	
	var end = Time.get_ticks_msec()
	text_label.append_text("Teste Equivalente a .append com dicionário levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	append += (end - start)
	
	# Modificação direta
	start = Time.get_ticks_msec()
	for i in range(N):
		dic[i] = i
	
	end = Time.get_ticks_msec()
	text_label.append_text("Teste de modificação direta com dicionário levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	modificacao_direta += (end - start)
	
	# .find_key
	start = Time.get_ticks_msec()
	for i in range(N):
		dic.find_key(i)  

	end = Time.get_ticks_msec()
	text_label.append_text("Teste .find_key com dicionário levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	find_key += (end - start)
	
	#busca_por_valor Busca por muitos valores dentro de chaves desconhecidas
	start = Time.get_ticks_msec()
	for x in range(N):
		for i in range(N):
			if dic[i] == i:
				break
	end = Time.get_ticks_msec()
	busca_por_valor += (end - start)
	text_label.append_text("Teste usando busca por valor com dicionário levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	# .has
	start = Time.get_ticks_msec()
	for i in range(N):
		dic.has(i)  # Verifica se a chave existe no dicionário

	end = Time.get_ticks_msec()
	text_label.append_text("Teste .has com dicionário levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	has += (end - start)
	
	#get direto com var unica, simular um caso com muitas coletas de dados unicas do dicionario
	var aux: int
	start = Time.get_ticks_msec()
	for i in range(N):
		aux = dic[i]
	end = Time.get_ticks_msec()
	text_label.append_text("Teste de get direto com dicionário levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	get_direto += (end - start)
	
	#get direto com array, usando size do dicionario e resize no array
	var array_aux: Array = []
	start = Time.get_ticks_msec()
	array_aux.resize(dic.size())
	for i in range(N):
		array_aux[i] = dic[i]
	end = Time.get_ticks_msec()
	text_label.append_text("Teste de get direto com dicionário usando arrays levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	get_direto_array += (end - start)
	
	#.erase
	
	start = Time.get_ticks_msec()
	
	for i in range(N):
		dic.erase(i)
	end = Time.get_ticks_msec()
	
	text_label.append_text("Teste .erase levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	
	erase += (end - start)
	
	### Casos especiais para comparar com erase
	#.clear
	# Gerar o dicionario novamente
	for i in range(N):
		dic[i] = i 
		
	start = Time.get_ticks_msec()
	dic.clear()
	end = Time.get_ticks_msec()
	
	clear += (end - start)
	text_label.append_text("Teste .clear levou "+ str(end - start)+ "ms, n° do teste"+ str(teste)+"\n")
	await get_tree().process_frame
