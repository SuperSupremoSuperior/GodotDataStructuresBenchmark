using Godot;
using System;
using System.Collections.Generic;
using System.Diagnostics;

public partial class TVector4 : Node
{
	//private RichTextLabel textLabel;
	private const int X = 4;

	private int append;
	private int findKey;
	private int buscaPorValor;
	private int has;
	private int modificacaoDireta;
	private int getDireto;
	private int getDiretoArray;
	private int erase;
	private int clear;

	[Export]
	public RichTextLabel textLabel { get; set; }

	public async override void _Ready()
	{

		if (textLabel == null)
		{
			GD.PrintErr("Erro: RichTextLabel não encontrado! Verifique o caminho no GetNode.");
		}
	}

	public async void StartTest(int tamanho, int numeroDeTestes)
	{
		int tamanhoFinal = tamanho * X;
		textLabel.AppendText($"O número de apurações é de {tamanhoFinal}\n");
		textLabel.ScrollToLine(textLabel.GetLineCount() - 1);

		for (int n = 0; n < numeroDeTestes; n++)
		{
			await TesteDicionario(tamanhoFinal, n + 1);
			textLabel.ScrollToLine(textLabel.GetLineCount() - 1);
		}

		textLabel.AppendText($"Valores finais em ms, após {numeroDeTestes} testes com tamanho total {tamanhoFinal}:\n" +
			$"append {append} (média: {append / numeroDeTestes})\n" +
			$"find_key {findKey} (média: {findKey / numeroDeTestes})\n" +
			$"busca por valor {buscaPorValor} (média: {buscaPorValor / numeroDeTestes})\n" +
			$"has {has} (média: {has / numeroDeTestes})\n" +
			$"modificação direta {modificacaoDireta} (média: {modificacaoDireta / numeroDeTestes})\n" +
			$"get_direto {getDireto} (média: {getDireto / numeroDeTestes})\n" +
			$"get_direto_array {getDiretoArray} (média: {getDiretoArray / numeroDeTestes})\n" +
			$"erase {erase} (média: {erase / numeroDeTestes})\n" +
			$"clear {clear} (média: {clear / numeroDeTestes})\n");

		textLabel.ScrollToLine(textLabel.GetLineCount() - 1);
	}

	private async System.Threading.Tasks.Task TesteDicionario(int N, int teste)
	{
		Dictionary<int, int> dic = new();
		Stopwatch stopwatch = new();

		void RegistrarTeste(string nome, Action acao, ref int acumulador)
		{
			stopwatch.Restart();
			acao();
			stopwatch.Stop();
			acumulador += (int)stopwatch.ElapsedMilliseconds;
			textLabel.AppendText($"{nome} levou {stopwatch.ElapsedMilliseconds}ms, teste {teste}\n");
		}

		RegistrarTeste("Append", () => {
			for (int i = 0; i < N; i++) dic[i] = i;
		}, ref append);

		RegistrarTeste("Modificação direta", () => {
			for (int i = 0; i < N; i++) dic[i] = i;
		}, ref modificacaoDireta);

		RegistrarTeste("Find Key", () => {
			for (int i = 0; i < N; i++) dic.ContainsKey(i);
		}, ref findKey);

		RegistrarTeste("Busca por valor", () => {
			for (int x = 0; x < N; x++)
				for (int i = 0; i < N; i++)
					if (dic[i] == i) break;
		}, ref buscaPorValor);

		RegistrarTeste("Has (ContainsKey)", () => {
			for (int i = 0; i < N; i++) dic.ContainsKey(i);
		}, ref has);

		int aux = 0;
		RegistrarTeste("Get direto", () => {
			for (int i = 0; i < N; i++) aux = dic[i];
		}, ref getDireto);

		int[] arrayAux = new int[dic.Count];
		RegistrarTeste("Get direto com array", () => {
			for (int i = 0; i < N; i++) arrayAux[i] = dic[i];
		}, ref getDiretoArray);

		RegistrarTeste("Erase", () => {
			for (int i = 0; i < N; i++) dic.Remove(i);
		}, ref erase);

		for (int i = 0; i < N; i++) dic[i] = i;
		RegistrarTeste("Clear", dic.Clear, ref clear);

		await ToSignal(GetTree(), "process_frame");
	}
}
