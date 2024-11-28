import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editMed_screen.dart';

class SearchMedScreen extends StatelessWidget {
  const SearchMedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Médicos'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('medicos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum médico encontrado.'));
          }

          final medicos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: medicos.length,
            itemBuilder: (context, index) {
              final medico = medicos[index].data() as Map<String, dynamic>;
              final docId = medicos[index].id;
              return _buildMedicoTile(
                context,
                medico['name'] ?? 'Nome indisponível',
                medico['specialty'] ?? 'Especialidade indisponível',
                medico['name']?[0]?.toUpperCase() ?? '?',
                medico,
                docId,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMedicoTile(
    BuildContext context,
    String nome,
    String especialidade,
    String inicial,
    Map<String, dynamic> medico,
    String docId,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          _showMedicoDetails(context, medico, docId);
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
            subtitle: Text(especialidade),
            trailing: const Icon(Icons.more_vert, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _showMedicoDetails(
      BuildContext context, Map<String, dynamic> medico, String docId) {
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
                            medico['name']?[0]?.toUpperCase() ?? '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          medico['name'] ?? 'Nome indisponível',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          medico['specialty'] ?? 'Especialidade indisponível',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditMedScreen(medico: medico, docId: docId),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailItem(
                    'CRM/RQE', medico['crm'] ?? 'CRM indisponível'),
                const SizedBox(height: 15),
                _buildDetailItem(
                    'Telefone', medico['phone'] ?? 'Telefone indisponível'),
                const SizedBox(height: 15),
                _buildDetailItem('Consulta Presencial',
                    medico['isPresencial'] == true ? 'Sim' : 'Não'),
                const SizedBox(height: 15),
                _buildDetailItem('Consulta Online',
                    medico['isOnline'] == true ? 'Sim' : 'Não'),
                const SizedBox(height: 15),
                _buildDetailItem(
                  'Dias de atendimento',
                  (medico['daysSelected'] is List)
                      ? (medico['daysSelected'] as List).join(' | ')
                      : medico['daysSelected'] ?? 'Dias indisponíveis',
                ),
                const SizedBox(height: 15),
                _buildDetailItem('Observações',
                    medico['observations'] ?? 'Nenhuma observação'),
                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
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
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
