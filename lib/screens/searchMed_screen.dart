import 'package:flutter/material.dart';

class SearchMedScreen extends StatelessWidget {
  const SearchMedScreen({Key? key}) : super(key: key);

  // Lista de médicos para preencher a lista
  final List<Map<String, dynamic>> medicos = const [
    {
      'nome': 'Dr. Kaue Oliver', 
      'especialidade': 'Fisioterapeuta', 
      'inicial': 'K',
      'crm': 'CRM/SC 123456',
      'telefone': '(00) 91234-5678',
      'consulta': 'Presencial | Online',
      'dias': 'Seg | Ter | Qui',
      'observacoes': 'Segunda e terça-feira, atendimento das 8h às 17h; Quarta-feira, das 9h às 18h.'
    },
    {
      'nome': 'Dr. Arthur Tiago', 
      'especialidade': 'Cardiologista', 
      'inicial': 'A',
      'crm': 'CRM/SP 987654',
      'telefone': '(11) 91234-5678',
      'consulta': 'Presencial',
      'dias': 'Seg | Qua | Sex',
      'observacoes': 'Segunda e quarta-feira, das 9h às 17h.'
    },
    // Adicione mais médicos conforme necessário...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Médicos'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: medicos.length,
        itemBuilder: (context, index) {
          final medico = medicos[index];
          return _buildMedicoTile(
            context,
            medico['nome'],
            medico['especialidade'],
            medico['inicial'],
            medico,
          );
        },
      ),
    );
  }

  // Função para construir um "ListTile" personalizado para cada médico
  Widget _buildMedicoTile(BuildContext context, String nome, String especialidade, String inicial, Map<String, dynamic> medico) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          _showMedicoDetails(context, medico);
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
                inicial,
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
            subtitle: Text(especialidade),
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

  // Função para exibir o Bottom Sheet com os detalhes do médico
  void _showMedicoDetails(BuildContext context, Map<String, dynamic> medico) {
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
                            medico['inicial'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          medico['nome'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Aumentando o tamanho da fonte para o nome
                          ),
                        ),
                        subtitle: Text(
                          medico['especialidade'],
                          style: const TextStyle(
                            fontSize: 16, // Aumentando o tamanho da fonte para a especialidade
                          ),
                        ),
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
                _buildDetailItem('Nome', medico['nome']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('CRM/RQE', medico['crm']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Telefone', medico['telefone']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Consulta', medico['consulta']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Dias de atendimento', medico['dias']),
                const SizedBox(height: 15), // Aumentando espaçamento entre os itens

                _buildDetailItem('Observações', medico['observacoes']),
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

  // Função para construir os detalhes de cada item do médico no BottomSheet
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
