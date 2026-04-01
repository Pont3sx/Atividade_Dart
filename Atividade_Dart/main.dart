import 'dart:io';

// Classe Tarefa
class Tarefa {
  int id;
  String titulo;
  String? descricao;
  bool concluida;

  Tarefa(this.id, this.titulo, {this.descricao, this.concluida = false});

  void marcarConcluida() {
    concluida = true;
  }

  void desmarcarConcluida() {
    concluida = false;
  }

  @override
  String toString() {
    String status = concluida ? "✔ Concluída" : "✘ Pendente";
    return "[$id] $titulo - $status ${descricao != null ? "\n   $descricao" : ""}";
  }
}

// Classe Gerenciador
class GerenciadorDeTarefas {
  List<Tarefa> tarefas = [];
  int _contadorId = 1;

  void adicionarTarefa(String titulo, {String? descricao}) {
    tarefas.add(Tarefa(_contadorId++, titulo, descricao: descricao));
    print("✔Tarefa adicionada!");
  }

  void listarTarefas() {
    if (tarefas.isEmpty) {
      print("Nenhuma tarefa cadastrada.");
      return;
    }

    for (var tarefa in tarefas) {
      print(tarefa);
    }
  }

  Tarefa? _buscarPorId(int id) {
    try {
      return tarefas.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  void editarTarefa(int id, String novoTitulo, String? novaDescricao) {
    var tarefa = _buscarPorId(id);

    if (tarefa == null) {
      print("Tarefa não encontrada.");
      return;
    }

    tarefa.titulo = novoTitulo;
    tarefa.descricao = novaDescricao;
    print("Tarefa atualizada!");
  }

  void removerTarefa(int id) {
    tarefas.removeWhere((t) => t.id == id);
    print("Tarefa removida!");
  }

  void alternarStatus(int id) {
    var tarefa = _buscarPorId(id);

    if (tarefa == null) {
      print("Tarefa não encontrada.");
      return;
    }

    tarefa.concluida = !tarefa.concluida;
    print(" Status atualizado!");
  }
}

// Função principal (CLI)
void main() {
  var gerenciador = GerenciadorDeTarefas();

  while (true) {
    print("\n==== GERENCIADOR DE TAREFAS ====");
    print("1. Adicionar tarefa");
    print("2. Listar tarefas");
    print("3. Editar tarefa");
    print("4. Remover tarefa");
    print("5. Marcar/Desmarcar tarefa");
    print("0. Sair");

    stdout.write("Escolha uma opção: ");
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        stdout.write("Título: ");
        String? titulo = stdin.readLineSync();

        if (titulo == null || titulo.trim().isEmpty) {
          print("Título inválido!");
          break;
        }

        stdout.write("Descrição (opcional): ");
        String? descricao = stdin.readLineSync();

        gerenciador.adicionarTarefa(titulo, descricao: descricao);
        break;

      case '2':
        gerenciador.listarTarefas();
        break;

      case '3':
        stdout.write("ID da tarefa: ");
        int? id = int.tryParse(stdin.readLineSync() ?? "");

        if (id == null) {
          print("ID inválido!");
          break;
        }

        stdout.write("Novo título: ");
        String? titulo = stdin.readLineSync();

        if (titulo == null || titulo.trim().isEmpty) {
          print("Título inválido!");
          break;
        }

        stdout.write("Nova descrição: ");
        String? descricao = stdin.readLineSync();

        gerenciador.editarTarefa(id, titulo, descricao);
        break;

      case '4':
        stdout.write("ID da tarefa: ");
        int? id = int.tryParse(stdin.readLineSync() ?? "");

        if (id == null) {
          print("ID inválido!");
          break;
        }

        gerenciador.removerTarefa(id);
        break;

      case '5':
        stdout.write("ID da tarefa: ");
        int? id = int.tryParse(stdin.readLineSync() ?? "");

        if (id == null) {
          print("ID inválido!");
          break;
        }

        gerenciador.alternarStatus(id);
        break;

      case '0':
        print("Saindo...");
        return;

      default:
        print("Opção inválida!");
    }
  }
}