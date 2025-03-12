using Godot;
using System;
using System.Diagnostics;
using System.Collections.Generic;

public partial class TArrays : Node
{
	private const int X = 4;
	//private RichTextLabel textLabel;

	private long append = 0, insert = 0, find = 0, has = 0, modificacaoDireta = 0, 
				sort = 0, sortInvertido = 0, getDireto = 0, appendArray = 0, 
				erase = 0, popBack = 0, size = 0, resize = 0;

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
		AppendText($"O número de apurações é de {tamanhoFinal}\n");

		for (int n = 0; n < numeroDeTestes; n++)
		{
			await TestArray(tamanhoFinal, n + 1);
		}

		AppendText($"Valores finais em ms após {numeroDeTestes} testes com tamanho total {tamanhoFinal}\n" +
			$"append {append} com média de {append / numeroDeTestes}\n" +
			$"insert {insert} com média de {insert / numeroDeTestes}\n" +
			$"find {find} com média de {find / numeroDeTestes}\n" +
			$"has {has} com média de {has / numeroDeTestes}\n" +
			$"modificação direta {modificacaoDireta} com média de {modificacaoDireta / numeroDeTestes}\n" +
			$"sort {sort} com média de {sort / numeroDeTestes}\n" +
			$"sort_invertido {sortInvertido} com média de {sortInvertido / numeroDeTestes}\n" +
			$"get_direto {getDireto} com média de {getDireto / numeroDeTestes}\n" +
			$"append_array {appendArray} com média de {appendArray / numeroDeTestes}\n" +
			$"erase {erase} com média de {erase / numeroDeTestes}\n" +
			$"pop_back {popBack} com média de {popBack / numeroDeTestes}\n" +
			"--- Casos especiais ---\n" +
			"size: sem loop\n" +
			"resize: usando loop apenas para set direto\n" +
			$"size {size} com média de {size / numeroDeTestes}\n" +
			$"resize {resize} com média de {resize / numeroDeTestes}\n");
	}

	private async System.Threading.Tasks.Task TestArray(int N, int teste)
	{
		List<int> array = new List<int>();
		Stopwatch stopwatch = new Stopwatch();

		// Append
		stopwatch.Start();
		for (int i = 0; i < N; i++)
			array.Add(i);
		stopwatch.Stop();
		append += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .append com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Insert
		array.Clear();
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			array.Insert(i, i);
		stopwatch.Stop();
		insert += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .insert com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Find
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			array.IndexOf(i);
		stopwatch.Stop();
		find += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .find com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Has
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			array.Contains(i);
		stopwatch.Stop();
		has += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .has com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Modificação direta
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			array[i] = i;
		stopwatch.Stop();
		modificacaoDireta += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste de modificação direta com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Sort
		stopwatch.Restart();
		array.Sort();
		stopwatch.Stop();
		sort += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .sort com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Sort Invertido
		array.Reverse();
		stopwatch.Restart();
		array.Sort();
		stopwatch.Stop();
		sortInvertido += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .sort com array invertido levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Get direto
		List<int> arrayParaGet = new List<int>(new int[N]);
		stopwatch.Restart();
		for (int i = 0; i < N; i++)
			arrayParaGet[i] = array[i];
		stopwatch.Stop();
		getDireto += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste de get direta com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Append array
		List<int> arrayParaAppendArray = new List<int>();
		stopwatch.Restart();
		arrayParaAppendArray.AddRange(array);
		stopwatch.Stop();
		appendArray += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste de append_array com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// Erase
		stopwatch.Restart();
		foreach (int i in array.ToArray())
			array.Remove(i);
		stopwatch.Stop();
		erase += stopwatch.ElapsedMilliseconds;
		textLabel.Text += $"Teste .erase com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";

		// .size

		stopwatch.Restart();
		int arraySize = array.Count;
		stopwatch.Stop();

		textLabel.Text += $"Teste .size com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";
		size += stopwatch.ElapsedMilliseconds;

		// .resize com adição direta
		array = new List<int>(N);

		stopwatch.Restart();
		for (int i = 0; i < N; i++)
		{
			array.Add(i);
		}
		stopwatch.Stop();

		textLabel.Text += $"Teste .resize com array levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";
		resize += stopwatch.ElapsedMilliseconds;
		await ToSignal(GetTree(), "process_frame");
		
		// pop_back equivalente (remoção do último elemento)
		var list = new System.Collections.Generic.List<int>(array);
		
		stopwatch.Restart();
		if (list.Count > 0)
		{
			list.RemoveAt(list.Count - 1);
		}
		stopwatch.Stop();
		
		textLabel.Text += $"Teste pop_back levou {stopwatch.ElapsedMilliseconds}ms, n° do teste {teste}\n";
		popBack += stopwatch.ElapsedMilliseconds;
		
		
	}

	private void AppendText(string text)
	{
		textLabel?.AppendText(text);
		textLabel?.ScrollToLine(textLabel.GetLineCount() - 1);
	}
}
