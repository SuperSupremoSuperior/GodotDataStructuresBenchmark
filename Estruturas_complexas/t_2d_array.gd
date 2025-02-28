extends Node

const X = 4

@onready var text_label = $"../Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/RichTextLabel"

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

func _start(Tamanho: int, numero_de_testes: int, tamanho_subteste: int):
	var Tamanho_final = Tamanho * X
	text_label.append_text("O numero de apurações é de " + str(Tamanho_final) + "\n")
	text_label.scroll_to_line(text_label.get_line_count() - 1)
	
	for n in range(numero_de_testes):
		await _teste_array2d(Tamanho_final, tamanho_subteste, n + 1)
		text_label.scroll_to_line(text_label.get_line_count() - 1)
	
	text_label.append_text("Valores finais em ms, após " + str(numero_de_testes) + " testes com tamanho total " + str(Tamanho_final) + " para\n" +
		"append " + str(append) + " com média de " + str(append / numero_de_testes) + "\n" +
		"insert " + str(insert) + " com média de " + str(insert / numero_de_testes) + "\n" +
		"find " + str(find) + " com média de " + str(find / numero_de_testes) + "\n" +
		"has " + str(has) + " com média de " + str(has / numero_de_testes) + "\n" +
		"modificação direta " + str(modificacao_direta) + " com média de " + str(modificacao_direta / numero_de_testes) + "\n" +
		"sort " + str(sort) + " com média de " + str(sort / numero_de_testes) + "\n" +
		"sort_invertido " + str(sort_invertido) + " com média de " + str(sort_invertido / numero_de_testes) + "\n" +
		"get_direto " + str(get_direto) + " com média de " + str(get_direto / numero_de_testes) + "\n" +
		"append_array " + str(append_array) + " com média de " + str(append_array / numero_de_testes) + "\n" +
		"erase " + str(erase) + " com média de " + str(erase / numero_de_testes) + "\n" +
		"pop_back " + str(pop_back) + " com média de " + str(pop_back / numero_de_testes) + "\n" +
		"size " + str(size) + " com média de " + str(size / numero_de_testes) + "\n" +
		"resize " + str(resize) + " com média de " + str(resize / numero_de_testes) + "\n"
	)
	text_label.scroll_to_line(text_label.get_line_count() - 1)

func _teste_array2d(N: int, tamanho_subteste: int, teste: int) -> void:
	#append
	var array2d: Array = []
	var start = Time.get_ticks_msec()
	for i in range(N):
		var sub_array: Array = []
		for j in range(tamanho_subteste):
			sub_array.append(j)
		array2d.append(sub_array)
	
	for i in range(N):
		for j in range(tamanho_subteste):
			array2d[i].append(j)
	var end = Time.get_ticks_msec()
	append += (end - start)
	text_label.append_text("Teste .append com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#insert
	start = Time.get_ticks_msec()
	for i in range(N):
		for j in range(tamanho_subteste):
			array2d[i].insert(0, j)
	end = Time.get_ticks_msec()
	insert += (end - start)
	text_label.append_text("Teste .insert com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#find
	start = Time.get_ticks_msec()
	for i in range(N):
		for j in range(tamanho_subteste):
			array2d[i].find(j)
	end = Time.get_ticks_msec()
	find += (end - start)
	text_label.append_text("Teste .find com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#has
	start = Time.get_ticks_msec()
	for i in range(N):
		for j in range(tamanho_subteste):
			array2d[i].has(j)
	end = Time.get_ticks_msec()
	has += (end - start)
	text_label.append_text("Teste .has com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#modificação direta
	start = Time.get_ticks_msec()
	for i in range(N):
		for j in range(tamanho_subteste):
			array2d[i][j] = j
	end = Time.get_ticks_msec()
	modificacao_direta += (end - start)
	text_label.append_text("Teste de modificação direta com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#sort
	start = Time.get_ticks_msec()
	for i in range(N):
		array2d[i].sort()
	end = Time.get_ticks_msec()
	sort += (end - start)
	text_label.append_text("Teste .sort com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#sort_invertido
	start = Time.get_ticks_msec()
	for i in range(N):
		array2d[i].reverse()
		array2d[i].sort()
	end = Time.get_ticks_msec()
	sort_invertido += (end - start)
	text_label.append_text("Teste .sort invertido com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	#size
	start = Time.get_ticks_msec()
	var size_total = 0
	for i in range(N):
		size_total += array2d[i].size()
	end = Time.get_ticks_msec()
	size += (end - start)
	text_label.append_text("Teste .size com Array2D levou " + str(end - start) + "ms, n° do teste " + str(teste) + "\n")
	
	await get_tree().process_frame
