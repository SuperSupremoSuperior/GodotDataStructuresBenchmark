extends TileMapLayer

const X = 4
@onready var text_label = $"../Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/RichTextLabel"

var append = 0
var get_direto = 0

func _start(Tamanho: int, numero_de_testes: int, tamanho_subteste: int):
	var Tamanho_final = Tamanho * X
	text_label.append_text("O numero de apurações é de " + str(Tamanho_final) + "\n")
	text_label.scroll_to_line(text_label.get_line_count() - 1)
	
	for n in range(numero_de_testes):
		await _teste_tilemap(Tamanho, tamanho_subteste, n + 1)
		text_label.scroll_to_line(text_label.get_line_count() - 1)
	
	text_label.append_text("Valores finais em ms, após " + str(numero_de_testes) + " testes com tamanho total " + str(Tamanho_final) + " para\n" +
		"append " + str(append) + " com média de " + str(append / numero_de_testes) + "\n" +
		"get_direto " + str(get_direto) + " com média de " + str(get_direto / numero_de_testes) + "\n"
	)
	text_label.scroll_to_line(text_label.get_line_count() - 1)

func _teste_tilemap(Tamanho: int, tamanho_subteste: int, teste: int) -> void:
	var start = Time.get_ticks_msec()
	for x in range(Tamanho):
		for y in range(tamanho_subteste):
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
	var end = Time.get_ticks_msec()
	append += (end - start)
	text_label.append_text("Teste .set_cell com TileMap levou " + str(end - start) + "ms, nº do teste " + str(teste) + "\n")

	start = Time.get_ticks_msec()
	for x in range(Tamanho):
		for y in range(tamanho_subteste):
			get_cell_atlas_coords(Vector2i(x, y))
	end = Time.get_ticks_msec()
	get_direto += (end - start)
	text_label.append_text("Teste .get_cell_atlas_coords com TileMap levou " + str(end - start) + "ms, nº do teste " + str(teste) + "\n")
	
	await get_tree().process_frame
