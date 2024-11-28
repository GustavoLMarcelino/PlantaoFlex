import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchConsultationScreen extends StatelessWidget {
  const SearchConsultationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Consultas'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('consultas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma consulta encontrada.'));
          }

          final consultas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: consultas.length,
            itemBuilder: (context, index) {
              final consulta = consultas[index].data() as Map<String, dynamic>;

              // Buscar nome do paciente e do médico
              return FutureBuilder(
                future: Future.wait([
                  _getPatientName(consulta['patientId']),
                  _getDoctorName(consulta['doctorId']),
                ]),
                builder: (context, AsyncSnapshot<List<String>> nameSnapshot) {
                  if (nameSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (nameSnapshot.hasError) {
                    return Center(child: Text('Erro ao carregar dados.'));
                  }

                  final patientName =
                      nameSnapshot.data?[0] ?? 'Paciente não encontrado';
                  final doctorName =
                      nameSnapshot.data?[1] ?? 'Médico não encontrado';

                  return _buildConsultaTile(
                    context,
                    consulta,
                    patientName,
                    doctorName,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Função para buscar o nome do paciente com base no patientId
  Future<String> _getPatientName(String patientId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('pacientes')
        .doc(patientId)
        .get();
    if (docSnapshot.exists) {
      return docSnapshot['nome'] ?? 'Nome não disponível';
    }
    return 'Paciente não encontrado';
  }

  // Função para buscar o nome do médico com base no doctorId
  Future<String> _getDoctorName(String doctorId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('medicos')
        .doc(doctorId)
        .get();
    if (docSnapshot.exists) {
      return docSnapshot['name'] ?? 'Nome não disponível';
    }
    return 'Médico não encontrado';
  }

  // Função para construir um "ListTile" personalizado para cada consulta
  Widget _buildConsultaTile(BuildContext context, Map<String, dynamic> consulta,
      String patientName, String doctorName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          _showConsultaDetails(context, consulta, patientName, doctorName);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: Text(
              'Paciente: $patientName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'Médico: $doctorName\n'
              'Data: ${consulta['appointmentDate'] ?? 'Data indisponível'}\n'
              'Hora: ${consulta['appointmentTime'] ?? 'Hora indisponível'}',
            ),
            trailing: const Icon(Icons.more_vert, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // Função para exibir o Bottom Sheet com os detalhes da consulta
  void _showConsultaDetails(BuildContext context, Map<String, dynamic> consulta,
      String patientName, String doctorName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75, // Define a altura como 75% da tela
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
                        title: Text(
                          'Paciente: $patientName',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text('Médico: $doctorName'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showEditMenu(context, consulta);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailItem('Data da Consulta',
                    consulta['appointmentDate'] ?? 'Não informada'),
                const SizedBox(height: 15),
                _buildDetailItem('Hora da Consulta',
                    consulta['appointmentTime'] ?? 'Não informada'),
                const SizedBox(height: 15),
                _buildDetailItem(
                    'Taxa', consulta['fee']?.toString() ?? 'Não informada'),
              ],
            ),
          ),
        );
      },
    );
  }

  // Função para construir os detalhes de cada item da consulta no BottomSheet
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

  // Função para exibir o menu de três pontos dentro do Bottom Sheet
  void _showEditMenu(BuildContext context, Map<String, dynamic> consulta) {
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
                // Implementar navegação para a tela de edição
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Excluir'),
              onTap: () {
                Navigator.pop(context);
                _showConfirmDeleteDialog(context, consulta);
              },
            ),
          ],
        );
      },
    );
  }

  // Função para exibir o pop-up de confirmação de exclusão
  void _showConfirmDeleteDialog(
      BuildContext context, Map<String, dynamic> consulta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir consulta?'),
          content: const Text(
              'Tem certeza de que deseja excluir esta consulta? Esta ação não pode ser desfeita.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo sem excluir
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                // Aqui você pode implementar a ação de excluir a consulta
                print('Consulta excluída');
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
