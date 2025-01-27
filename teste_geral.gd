extends Node

### Teste para estrtuturas simples de dados
#Array
#Dicionario
#Vetores, lista de Vector2 - Vector3 e Vector4 são na pratica array de tamanho imutaveis de tamanho 2, 3 e 4 respectivamente
#PackedArray são Array teoricamente mais eficientes para guardar info em troca de performance da hora mudar seu tamanho

### Para fazer uma avaliação do tempo usado usaremos a biblioteca nativa do godot Time
#var start = Time.get_ticks_msec()
#Função...
#var end = Time.get_ticks_msec()
#print("Nome do teste ", (end - start), "ms")

### Export é usado para poder modificr o valor atravez da propria interface da Engine
@export var Tamanho: int = 4
@export var numero_de_testes: int = 1 # Para testar n vezes

#Para um teste mais apurado como usaremos tambem Vector4 então mutiplicaremos o tamanho por 4 sempre, no resultado mostrara
#O Tamanho*4 como tamanho total

@export_enum("Arrays", "Dicionarios", "Vector4", "PackedInt64Array", "PackedInt32Array") var func_selecionada: String

#onready é usado para encontrar os nos antes de executar _ready(), assim atribuido os nos a uma variavel
@onready var t_arrays = $T_Arrays
@onready var t_dictionary = $T_Dictionary
@onready var t_vector_4 = $T_Vector4
@onready var t_packed_array_int_64 = $T_PackedArrayInt64
@onready var t_packed_array_int_32 = $T_PackedArrayInt32

###Notas Adicionais alguns elementos nos testes foram feitos como algo extra que não precisão estar diretamente ligados com loops
'''Para Arrays:'''
#.size para encontrar o tamanho de um array, não fizemos loops, pois isso na pratica provavelmente nunca será usado
#.resize é executado apenas uma vez para mudar o tamanho de um array vazio, assim fazendo dentro dele uma modificação direta em loop
'''Para Dicionarios'''

'''Para Vector4'''

'''Para PackedInt64Array'''

'''Para PackedInt32Array'''

func _ready():
	match func_selecionada:
		"Arrays": 
			t_arrays.start(Tamanho, numero_de_testes)
		"Dicionarios":
			t_dictionary.start(Tamanho, numero_de_testes)
		"Vector4":
			t_vector_4.start(Tamanho, numero_de_testes)
		"PackedArraysInt64":
			t_packed_array_int_64.start(Tamanho, numero_de_testes)
		"PackedArraysInt32":
			t_packed_array_int_32.start(Tamanho, numero_de_testes)

	print("Estes Foram os resultados para um teste simples com a estrutura ", func_selecionada)
