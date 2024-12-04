import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'EditCli_screen.dart';

class SearchClientScreen extends StatelessWidget {
  const SearchClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Clientes'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pacientes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum cliente encontrado.'));
          }

          final clientes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index].data() as Map<String, dynamic>;
              final docId = snapshot.data!.docs[index].id;

              // Debug para verificar dados recuperados
              debugPrint("Cliente recuperado: $cliente");

              return _buildClientTile(
                context,
                cliente['nome'] ?? 'Nome indisponível',
                cliente,
                docId,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildClientTile(
    BuildContext context,
    String nome,
    Map<String, dynamic> cliente,
    String docId,
  ) {
    // Acesso ao campo de nascimento
    final dataNascimento =
        cliente['nascimento']?.toString() ?? 'Data não disponível';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          _showClientDetails(context, cliente, docId);
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
                nome[0], // Primeira letra do nome
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text('Nascimento: $dataNascimento'),
            trailing: const Icon(Icons.more_vert, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _showClientDetails(
    BuildContext context,
    Map<String, dynamic> cliente,
    String docId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 1, 118, 115),
                          child: Text(
                            cliente['nome'][0],
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
                            fontSize: 20,
                          ),
                        ),
                        subtitle: const Text('Cliente'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showEditMenu(context, cliente, docId);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailItem('Nome', cliente['nome']),
                const SizedBox(height: 15),
                // Garantindo que estamos exibindo o campo correto de nascimento
                _buildDetailItem('Data de Nascimento',
                    cliente['nascimento']?.toString() ?? 'Data não disponível'),
                const SizedBox(height: 15),
                _buildDetailItem('CPF', cliente['cpf'] ?? 'Não informado'),
                const SizedBox(height: 15),
                _buildDetailItem('RG', cliente['rg'] ?? 'Não informado'),
                const SizedBox(height: 15),
                _buildDetailItem(
                    'Telefone', cliente['telefone'] ?? 'Não informado'),
                const SizedBox(height: 15),
                _buildDetailItem('Email', cliente['email'] ?? 'Não informado'),
                const SizedBox(height: 15),
                _buildDetailItem(
                    'Observações', cliente['observacoes'] ?? 'Nenhuma'),
                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditMenu(
      BuildContext context, Map<String, dynamic> cliente, String docId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditCliScreen(cliente: cliente, docId: docId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Excluir'),
              onTap: () {
                Navigator.pop(context);
                _deleteClient(docId, context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteClient(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(docId)
          .delete();
      // Fecha o BottomSheet
      Navigator.pop(context); // Fecha o BottomSheet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente excluído com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir cliente: $e')),
      );
    }
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
