extends Node


#var Tamanho: int
#var numero_de_testes: int # Para testar n vezes
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
#Para um teste mais apurado como usaremos tambem Vector4 seria bom o tamanho ter um multiplo de 4 como tamanho




func start(Tamanho: int, numero_de_testes: int):
	var Tamanho_final = Tamanho * X
	print("O numero de apurações é de ", Tamanho_final)
	var teste = 0
	for n in range(numero_de_testes):
		teste += 1
		_teste_array(Tamanho_final, teste)
	print("Valores finais em ms, apos ",numero_de_testes," testes com tamanho total ",Tamanho_final ," para
	append ", append," com media de ", (append/numero_de_testes),"
	insert ", insert," com media de ", (insert/numero_de_testes),"
	find ", find," com media de ", (find/numero_de_testes), "
	has ", has," com media de ", (has/numero_de_testes), "
	modificação direta ", modificacao_direta," com media de ", (modificacao_direta/numero_de_testes),"
	sort ", sort," com media de ", (sort/numero_de_testes),"
	sort_invertido ", sort_invertido," com media de ", (sort_invertido/numero_de_testes), "
	get_direto ", get_direto," com media de ", (get_direto/numero_de_testes), "
	append_array ", append_array," com media de ", (append_array/numero_de_testes), "
	erase ", erase," com media de ", (erase/numero_de_testes), "
	pop_back ", pop_back," com media de ", (pop_back/numero_de_testes), "
	size ", size," com media de ", (size/numero_de_testes), "
	resize ", resize," com media de ", (resize/numero_de_testes), ""
	)


func _teste_array(N: int, teste: int) -> void:
	#.append
	var start = Time.get_ticks_msec()
	
	var array: Array = []
	
	for i in range(N):
		array.append(i)
	var end = Time.get_ticks_msec()
	print("Teste .append com array levou ", (end - start), "ms, n° do teste", teste)
	
	append += (end - start)
	#.insert .... isso tera um efeito semelhante a .append o tamanho por isso array sera limpo para o proximo teste
	array = []

	start = Time.get_ticks_msec()
	for i in range(N):
		array.insert(i, i)

	end = Time.get_ticks_msec()
	print("Teste .insert com array levou ", (end - start), "ms, n° do teste", teste)
	
	insert += (end - start)
	#.find
	start = Time.get_ticks_msec()
	for i in range(N):
		array.find(i)

	end = Time.get_ticks_msec()
	print("Teste .find com array levou ", (end - start), "ms, n° do teste", teste)
	
	find += (end - start)
	#.has
	start = Time.get_ticks_msec()
	for i in range(N):
		array.has(i)

	end = Time.get_ticks_msec()
	print("Teste .has com array levou ", (end - start), "ms, n° do teste", teste)
	
	has += (end - start)
	#Modificação direta ... OBS: não é possivel aumentar o tamanho do array desta forma
	start = Time.get_ticks_msec()
	for i in range(N):
		array[i] = i

	end = Time.get_ticks_msec()
	print("Teste de modificação direta com array levou ", (end - start), "ms, n° do teste", teste)

	modificacao_direta += (end - start)
	#.sort
	start = Time.get_ticks_msec()
	array.sort()

	end = Time.get_ticks_msec()
	print("Teste .sort com array levou ", (end - start), "ms, n° do teste", teste)

	sort += (end - start)
	#.sort com array invertido
	array.reverse()
	
	start = Time.get_ticks_msec()
	array.sort()

	end = Time.get_ticks_msec()
	print("Teste .sort com array invertido com array levou ", (end - start), "ms, n° do teste", teste)

	sort_invertido += (end - start)
	#get direto
	var array_para_get: Array = []
	for i in range(N):
		array_para_get.append(N+1)
	
	start = Time.get_ticks_msec()
	for i in range(N):
		array_para_get[i] = array[i]

	end = Time.get_ticks_msec()
	print("Teste de get direta com array levou ", (end - start), "ms, n° do teste", teste)
	
	get_direto += (end - start)
	#.append_array
	var array_para_append_array: Array = []

	start = Time.get_ticks_msec()
	array_para_append_array.append_array(array)
	
	end = Time.get_ticks_msec()
	print("Teste de append_array com array levou ", (end - start), "ms, n° do teste", teste)

	append_array += (end - start)
	#.erase
	start = Time.get_ticks_msec()
	for i in range(N):
		array.erase(i)

	end = Time.get_ticks_msec()
	print("Teste .erase com array levou ", (end - start), "ms, n° do teste", teste)

	erase += (end - start)
	#pop_back ... no teste anterior o array foi apagado faremos ele denovo
	array = []
	for i in range(N):
		array.append(i)
	
	start = Time.get_ticks_msec()
	for i in range(N):
		array.pop_back() #Nota que isso retorna i valor que foi tirado no pop

	end = Time.get_ticks_msec()
	print("Teste .pop_back com array levou ", (end - start), "ms, n° do teste", teste)
	
	pop_back += (end - start)
	### Extras esta parte envolve benchmarks menos uteis
	#.size
	array = []
	for i in range(N):
		array.append(i)
	
	
	start = Time.get_ticks_msec()
	var size = array.size()

	end = Time.get_ticks_msec()
	print("Teste .size com array levou ", (end - start), "ms, n° do teste", teste)

	size += (end - start)
	#.resize com adição direta, teste para ver se isto é mais otimo que .append
	array = []
	array.resize(N)
	
	start = Time.get_ticks_msec()
	for i in range(N):
		array[i] = i
	end = Time.get_ticks_msec()
	print("Teste .resize com array levou ", (end - start), "ms, n° do teste", teste)

	resize += (end - start)
