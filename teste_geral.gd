extends Node
@onready var text_label = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/RichTextLabel

@onready var line_edit_tamanho = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/LineEdit
@onready var line_edit_n = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/LineEdit2
@onready var line_edit_subteste = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/LineEdit3

@onready var error_label = $Control/ErrorPanel/Label
@onready var error_panel = $Control/ErrorPanel

@onready var info_panel = $Control/Info_Panel

@onready var file_dialog = $FileDialog
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
@export var tamanho_subteste: int = 0

#Para um teste mais apurado como usaremos tambem Vector4 então mutiplicaremos o tamanho por 4 sempre, no resultado mostrara
#O Tamanho*4 como tamanho total

@export_enum("Arrays", "Dicionarios", "Vector4", "PackedInt64Array", "PackedInt32Array") var func_selecionada: String

#onready é usado para encontrar os nos antes de executar _ready(), assim atribuido os nos a uma variavel
@onready var t_arrays = $T_Arrays
@onready var t_dictionary = $T_Dictionary
@onready var t_vector_4 = $T_Vector4
@onready var t_packed_array_int_64 = $T_PackedArrayInt64
@onready var t_packed_array_int_32 = $T_PackedArrayInt32
@onready var t_packed_float_32_array = $T_PackedFloat32Array
@onready var t_packed_float_64_array = $T_PackedFloat64Array
@onready var t_2d_array = $T_2DArray
@onready var t_tilemap = $T_tilemap

@onready var C_t_arrays = $T_C/T_Arrays
@onready var C_t_dictionary = $T_C/T_Dictionary
@onready var C_t_vector_4 = $T_C/T_Vector4



###Notas Adicionais alguns elementos nos testes foram feitos como algo extra que não precisão estar diretamente ligados com loops
'''Para Arrays:'''
#.size para encontrar o tamanho de um array, não fizemos loops, pois isso na pratica provavelmente nunca será usado
#.resize é executado apenas uma vez para mudar o tamanho de um array vazio, assim fazendo dentro dele uma modificação direta em loop
'''Para Dicionarios'''
#Teste especial usando clear
'''Para Vector4'''
# Alguns elementos são testados dentro de um array para ver se isso é mais rapido que usar o array sozinho
# Isso tambem por que não é nenhum pouco comum alguem usar muitos vec4 em um for, normalmente sempre sendo simplificados para um array ou dicionario
'''Para PackedInt64Array'''
# Segue mesma ideia que array porem sem erase pois isso não existe para esta estrutura
'''Para PackedInt32Array'''
# Segue mesma ideia que array porem sem erase pois isso não existe para esta estrutura
func _ready():
	text_label.append_text("Resultados aqui \n ")

func on_buttom_press() -> void:
	if line_edit_n.text.is_valid_int() == false:
		error_panel.visible = true
		error_label.text = "O valor deve ser um inteiro"
		return
	if line_edit_tamanho.text.is_valid_int() == false:
		error_panel.visible = true
		error_label.text = "O valor deve ser um inteiro"
		return
	#if line_edit_subteste.text.is_valid_int() == false and line_edit_subteste.text != "":
		#error_panel.visible = true
		#error_label.text = "O valor deve ser um inteiro"
		#
		#return
	#if line_edit_subteste.text == "":
		#tamanho_subteste = 0
		
		
	Tamanho = int(line_edit_tamanho.text) 
	
	numero_de_testes = int(line_edit_n.text)
	

	
	if $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/OptionButton2.text == "GDScript":
		match $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/OptionButton.text:
			"Array": 
				t_arrays._start(Tamanho, numero_de_testes)
			"Dicionario":
				t_dictionary._start(Tamanho, numero_de_testes)
			"Vector4":
				t_vector_4._start(Tamanho, numero_de_testes)
			"PackedInt64Array":
				t_packed_array_int_64._start(Tamanho, numero_de_testes)
			"PackedInt32Array":
				t_packed_array_int_32._start(Tamanho, numero_de_testes)
			"PackedFloat64Array":
				t_packed_float_64_array._start(Tamanho, numero_de_testes)
			"PackedFloat32Array":
				t_packed_float_32_array._start(Tamanho, numero_de_testes)
			"Array2D":
				if line_edit_subteste.text.is_valid_int() == false and line_edit_subteste.text != "":
					error_panel.visible = true
					error_label.text = "O valor deve ser um inteiro"
					
					return
				tamanho_subteste = int(line_edit_subteste.text)
				t_2d_array._start(Tamanho, numero_de_testes, tamanho_subteste)
			"TileMap":
				if line_edit_subteste.text.is_valid_int() == false and line_edit_subteste.text != "":
					error_panel.visible = true
					error_label.text = "O valor deve ser um inteiro"
					
					return
				tamanho_subteste = int(line_edit_subteste.text)
				t_tilemap._start(Tamanho, numero_de_testes, tamanho_subteste)
	else:
		match $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/OptionButton.text:
			"Array": 
				C_t_arrays.StartTest(Tamanho, numero_de_testes)
			"Dicionario":
				C_t_dictionary.StartTest(Tamanho, numero_de_testes)
			"Vector4":
				C_t_vector_4.StartTest(Tamanho, numero_de_testes)

	print("Estes Foram os resultados para um teste simples com a estrutura ", $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/OptionButton.text)

func on_exit_error_panel_pressed() -> void:
	error_panel.visible = false

func on_exit_info_panel_pressed() -> void:
	info_panel.visible = false
	
func on_enter_info_panel_pressed() -> void:
	info_panel.visible = true

func on_clear_pressed() -> void:
	text_label.clear()
	
func on_save_pressed() -> void:
	var file_dialog = FileDialog.new()
	add_child(file_dialog)
	file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	file_dialog.add_filter("*.txt ; Text Files")
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM

	file_dialog.file_selected.connect(func(path):
		var file = FileAccess.open(path, FileAccess.WRITE)
		if file:
			file.store_string(text_label.get_parsed_text())  # Obtém o texto renderizado
			file.close()
			print("Arquivo salvo em:", path)
		else:
			print("Erro ao salvar arquivo!")
		
		file_dialog.queue_free()
	)

	file_dialog.popup_centered_clamped()
