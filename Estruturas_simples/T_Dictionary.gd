extends Node

#var Tamanho: int
#var numero_de_testes: int # Para testar n vezes
const X = 4

var append = 0
var insert = 0
var find_key = 0
var busca_por_valor = 0
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
#Para um teste mais apurado como usaremos tambem Vector4 seria bom o tamanho ter um multiplo de 4 como tamanho

func start(Tamanho: int, numero_de_testes: int):
	var Tamanho_final = Tamanho * X
	print("O numero de apurações é de ", Tamanho_final)
	var teste = 0
	for n in range(numero_de_testes):
		teste += 1
		_teste_dicionario(Tamanho_final, teste)
	print("Valores finais em ms, apos ",numero_de_testes," testes com tamanho total ",Tamanho_final ," para
	append ", append," com media de ", (append/numero_de_testes),"
	find_key ", find_key," com media de ", (find_key/numero_de_testes), "
	busca por valor ", busca_por_valor," com media de ", (busca_por_valor/numero_de_testes), "
	has ", has," com media de ", (has/numero_de_testes), "
	modificação direta ", modificacao_direta," com media de ", (modificacao_direta/numero_de_testes),"
	sort não possui um equivalente real para dicionarios
	...
	get_direto ", get_direto," com media de ", (get_direto/numero_de_testes), "
	append_array ", append_array," com media de ", (append_array/numero_de_testes), "
	erase ", erase," com media de ", (erase/numero_de_testes), "
	pop_back ", pop_back," com media de ", (pop_back/numero_de_testes), "
	size ", size," com media de ", (size/numero_de_testes), "
	resize ", resize," com media de ", (resize/numero_de_testes), ""
	)

func _teste_dicionario(N: int, teste: int) -> void:
	# .append
	var dic: Dictionary = {}

	var start = Time.get_ticks_msec()
	
	for i in range(N):
		dic[i] = i 
	
	var end = Time.get_ticks_msec()
	print("Teste Equivalente a .append com dicionário levou ", (end - start), "ms, n° do teste", teste)
	
	append += (end - start)
	
	# Modificação direta
	start = Time.get_ticks_msec()
	for i in range(N):
		dic[i] = i
	
	end = Time.get_ticks_msec()
	print("Teste de modificação direta com dicionário levou ", (end - start), "ms, n° do teste", teste)
	
	modificacao_direta += (end - start)
	
	# .find_key
	start = Time.get_ticks_msec()
	for i in range(N):
		dic.find_key(i)  

	end = Time.get_ticks_msec()
	print("Teste .find_key com dicionário levou ", (end - start), "ms, n° do teste", teste)
	
	find_key += (end - start)
	
	#busca_por_valor Busca por muitos valores dentro de chaves desconhecidas
	for x in range(N):
		for i in range(N):
			if dic[i][0] == i:
				break
	
	busca_por_valor += (end - start)
	
	# .has
	start = Time.get_ticks_msec()
	for i in range(N):
		dic.has(i)  # Verifica se a chave existe no dicionário

	end = Time.get_ticks_msec()
	print("Teste .has com dicionário levou ", (end - start), "ms, n° do teste", teste)
	
	has += (end - start)
