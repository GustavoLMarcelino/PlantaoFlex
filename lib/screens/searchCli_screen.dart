import 'package:flutter/material.dart';

class SearchClientScreen extends StatelessWidget {
  const SearchClientScreen({Key? key}) : super(key: key);

  // Lista de clientes para preencher a lista
  final List<Map<String, dynamic>> clientes = const [
    {
      'nome': 'João Silva', 
      'nascimento': '12/03/1980', 
      'cpf': '123.456.789-00',
      'rg': '12.345.678-9',
      'telefone': '(11) 91234-5678',
      'email': 'joao.silva@email.com',
      'observacoes': 'Cliente prefere atendimento matutino.',
    },
    {
      'nome': 'Maria Oliveira', 
      'nascimento': '22/07/1992', 
      'cpf': '987.654.321-00',
      'rg': '98.765.432-1',
      'telefone': '(21) 98765-4321',
      'email': 'maria.oliveira@email.com',
      'observacoes': 'Necessário lembrar sobre alergias a medicamentos.',
    },
    // Adicione mais clientes conforme necessário...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Clientes'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          return _buildClientTile(
            context,
            cliente['nome'],
            cliente,
          );
        },
      ),
    );
  }

  // Função para construir um "ListTile" personalizado para cada cliente
  Widget _buildClientTile(BuildContext context, String nome, Map<String, dynamic> cliente) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          _showClientDetails(context, cliente);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 1, 118, 115),
              child: Text(
                nome[0], // Pega a primeira letra do nome
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text('Cliente'),
            trailing: SizedBox(
              width: 100, // Largura total da área de ações à direita
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.edit, color: Colors.grey),
                  Icon(Icons.more_vert, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Função para exibir o Bottom Sheet com os detalhes do cliente
  void _showClientDetails(BuildContext context, Map<String, dynamic> cliente) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite maior controle sobre a altura
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75, // Define a altura como 75% da tela
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Faz o BottomSheet ajustar-se ao conteúdo
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 1, 118, 115),
                          child: Text(
                            cliente['nome'][0], // Pega a primeira letra do nome
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          cliente['nome'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Aumentando o tamanho da fonte para o nome
                          ),
                        ),
                        subtitle: const Text('Cliente'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showEditMenu(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Maior espaçamento entre as linhas

                // Detalhes com espaçamento e fonte maior
                _buildDetailItem('Nome', cliente['nome']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Data de Nascimento', cliente['nascimento']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('CPF', cliente['cpf']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('RG', cliente['rg']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Telefone', cliente['telefone']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Email', cliente['email']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Observações', cliente['observacoes']),
                const SizedBox(height: 25), // Espaçamento extra antes de fechar
              ],
            ),
          ),
        );
      },
    );
  }

  // Função para exibir o menu de três pontos dentro do Bottom Sheet
  void _showEditMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true, // Ajusta o tamanho ao conteúdo
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                // Ação de editar
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Excluir'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                // Ação de excluir
              },
            ),
          ],
        );
      },
    );
  }

  // Função para construir os detalhes de cada item do cliente no BottomSheet
  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16, // Aumentando o tamanho da fonte para o título
          ),
        ),
        const SizedBox(height: 5), // Espaço pequeno entre título e valor
        Text(
          value,
          style: const TextStyle(
            fontSize: 16, // Aumentando o tamanho da fonte para o valor
          ),
        ),
      ],
    );
  }
}
