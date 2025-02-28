using Godot;
using System;
using System.Collections.Generic;
using System.Diagnostics;

public partial class TDictionary : Node
{
	//private RichTextLabel textLabel;
	private const int X = 4;

	private int append = 0;
	private int findKey = 0;
	private int buscaPorValor = 0;
	private int has = 0;
	private int modificacaoDireta = 0;
	private int getDireto = 0;
	private int getDiretoArray = 0;
	private int erase = 0;
	private int clear = 0;

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

		textLabel.AppendText($"Valores finais em ms, após {numeroDeTestes} testes com tamanho total {tamanhoFinal} para\n" +
			$"append {append} com média de {append / numeroDeTestes}\n" +
			$"find_key {findKey} com média de {findKey / numeroDeTestes}\n" +
			$"busca por valor {buscaPorValor} com média de {buscaPorValor / numeroDeTestes}\n" +
			$"has {has} com média de {has / numeroDeTestes}\n" +
			$"modificação direta {modificacaoDireta} com média de {modificacaoDireta / numeroDeTestes}\n" +
			$"get_direto {getDireto} com média de {getDireto / numeroDeTestes}\n" +
			$"get_direto_array {getDiretoArray} com média de {getDiretoArray / numeroDeTestes}\n" +
			$"erase {erase} com média de {erase / numeroDeTestes}\n" +
			"--- Casos Especiais --- elementos sem loops\n" +
			$"clear {clear} com média de {clear / numeroDeTestes}\n");

		textLabel.ScrollToLine(textLabel.GetLineCount() - 1);
	}

	private async System.Threading.Tasks.Task TesteDicionario(int N, int teste)
	{
		Dictionary<int, int> dic = new Dictionary<int, int>();
		Stopwatch stopwatch = new Stopwatch();

		// Append
		stopwatch.Start();
		for (int i = 0; i < N; i++)
			dic[i] = i;
		stopwatch.Stop();
		append += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste Equivalente a .append com dicionário levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Modificação direta
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			dic[i] = i;
		stopwatch.Stop();
		modificacaoDireta += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste de modificação direta com dicionário levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Find Key
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			dic.ContainsKey(i);
		stopwatch.Stop();
		findKey += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste .find_key com dicionário levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Busca por valor
		stopwatch.Restart();
		for (int x = 0; x < N; x++)
			for (int i = 0; i < N; i++)
				if (dic[i] == i) break;
		stopwatch.Stop();
		buscaPorValor += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste usando busca por valor com dicionário levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Has (ContainsKey)
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			dic.ContainsKey(i);
		stopwatch.Stop();
		has += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste .has com dicionário levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Get direto
		int aux;
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			aux = dic[i];
		stopwatch.Stop();
		getDireto += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste de get direto com dicionário levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Get direto com array
		int[] arrayAux = new int[dic.Count];
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			arrayAux[i] = dic[i];
		stopwatch.Stop();
		getDiretoArray += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste de get direto com dicionário usando arrays levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Erase
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			dic.Remove(i);
		stopwatch.Stop();
		erase += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste .erase levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		// Clear
		for (int i = 0; i < N; i++)
			dic[i] = i;

		stopwatch.Restart();
		dic.Clear();
		stopwatch.Stop();
		clear += (int)stopwatch.ElapsedMilliseconds;
		textLabel.AppendText($"Teste .clear levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n");

		await ToSignal(GetTree(), "process_frame");
	}
}
