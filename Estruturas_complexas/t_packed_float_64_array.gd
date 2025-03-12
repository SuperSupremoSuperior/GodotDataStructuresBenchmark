extends Node
@onready var text_label = $"../Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/RichTextLabel"

const X = 4

var append = 0
var insert = 0
var find = 0
var has = 0
var modificacao_direta = 0
var sort = 0
var sort_invertido  = 0
var get_direto = 0
var append_array = 0
var erase = 0
var pop_back = 0
var size = 0
var resize = 0

func _start(Tamanho: int, numero_de_testes: int):
	var Tamanho_final = Tamanho * X
	text_label.append_text("O numero de apurações é de "+ str(Tamanho_final)+"\n")
	var teste = 0
	for n in range(numero_de_testes):
		teste += 1
		await _teste_array(Tamanho_final, teste)
		
	text_label.append_text("Valores finais em ms, apos "+str(numero_de_testes)+" testes com tamanho total "+str(Tamanho_final) +" para
	append "+ str(append)+" com media de "+ str(append/numero_de_testes)+"
	insert "+ str(insert)+" com media de "+ str(insert/numero_de_testes)+"
	find "+ str(find)+" com media de "+ str(find/numero_de_testes)+ "
	has "+ str(has)+" com media de "+ str(has/numero_de_testes)+ "
	modificação direta "+ str(modificacao_direta)+" com media de "+ str(modificacao_direta/numero_de_testes)+"
	sort "+ str(sort)+" com media de "+ str(sort/numero_de_testes)+"
	sort_invertido "+ str(sort_invertido)+" com media de "+ str(sort_invertido/numero_de_testes)+ "
	get_direto "+ str(get_direto)+" com media de "+ str(get_direto/numero_de_testes)+ "
	append_array "+ str(append_array)+" com media de "+ str(append_array/numero_de_testes)+ "\n
	erase Não existe em PackedArray\n"+
	"pop_back "+ str(pop_back)+" com media de "+ str(pop_back/numero_de_testes)+ "
	--- Casos especiais --- 
	size: sem loop
	resize: usando loop apenas para set direto
	size "+ str(size)+" com media de "+ str(size/numero_de_testes)+ "
	resize "+ str(resize)+" com media de "+ str(resize/numero_de_testes)+ ""
	)

func _teste_array(N: int, teste: int) -> void:
	var start = Time.get_ticks_msec()
	var array = PackedFloat64Array()
	for i in range(N):
		array.append(i)
	var end = Time.get_ticks_msec()
	text_label.append_text("Teste .append levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	append += (end - start)
	
	# .insert
	array = PackedFloat64Array()
	start = Time.get_ticks_msec()
	for i in range(N):
		array.insert(i, i)
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .insert levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	insert += (end - start)
	
	# .find
	start = Time.get_ticks_msec()
	for i in range(N):
		array.find(i)
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .find levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	find += (end - start)
	
	# .has
	start = Time.get_ticks_msec()
	for i in range(N):
		array.has(i)
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .find levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	has += (end - start)
	
	# Modificação direta
	start = Time.get_ticks_msec()
	for i in range(N):
		array[i] = i
	end = Time.get_ticks_msec()
	text_label.append_text("Teste de modificação direta levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	modificacao_direta += (end - start)
	
	# .sort
	start = Time.get_ticks_msec()
	array.sort()
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .sort levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	sort += (end - start)
	
	# .sort_invertido
	array.reverse()
	start = Time.get_ticks_msec()
	array.sort()
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .sort invertido levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	sort_invertido += (end - start)
	
	# get direto
	var array_para_get = PackedFloat64Array()
	array_para_get.resize(N)
	start = Time.get_ticks_msec()
	for i in range(N):
		array_para_get[i] = array[i]
	end = Time.get_ticks_msec()
	text_label.append_text("Teste de get direta levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	get_direto += (end - start)
	
	# .append_array
	var array_para_append_array = PackedFloat64Array()
	start = Time.get_ticks_msec()
	array_para_append_array.append_array(array)
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .append_array levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	append_array += (end - start)

	# .pop_back
	array = PackedFloat64Array()
	for i in range(N):
		array.append(i)
	start = Time.get_ticks_msec()
	for i in range(N):
		array.resize(array.size() - 1)
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .pop_back levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	pop_back += (end - start)
	
	# .size
	array = PackedFloat64Array()
	for i in range(N):
		array.append(i)
	start = Time.get_ticks_msec()
	var s = array.size()
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .size levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	size += (end - start)
	
	# .resize
	array = PackedFloat64Array()
	start = Time.get_ticks_msec()
	array.resize(N)
	for i in range(N):
		array[i] = i
	end = Time.get_ticks_msec()
	text_label.append_text("Teste .resize levou "+ str(end - start)+ "ms, teste "+ str(teste)+"\n")
	resize += (end - start)
	
	await get_tree().process_frame
