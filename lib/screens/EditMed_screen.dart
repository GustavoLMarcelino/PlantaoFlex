import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditMedScreen extends StatefulWidget {
  final Map<String, dynamic> medico;
  final String docId;

  const EditMedScreen({Key? key, required this.medico, required this.docId})
      : super(key: key);

  @override
  State<EditMedScreen> createState() => _EditMedScreenState();
}

class _EditMedScreenState extends State<EditMedScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _especialidadeController;
  late TextEditingController _crmController;
  late TextEditingController _telefoneController;
  late TextEditingController _observacoesController;

  bool _consultaPresencial = false;
  bool _consultaOnline = false;
  List<bool> _diasSelecionados = [false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.medico['name']);
    _especialidadeController =
        TextEditingController(text: widget.medico['specialty']);
    _crmController = TextEditingController(text: widget.medico['crm']);
    _telefoneController = TextEditingController(text: widget.medico['phone']);
    _observacoesController =
        TextEditingController(text: widget.medico['observations'] ?? '');
    _consultaPresencial = widget.medico['isPresencial'] ?? false;
    _consultaOnline = widget.medico['isOnline'] ?? false;

    if (widget.medico['daysSelected'] is List) {
      List<String> dias = List<String>.from(widget.medico['daysSelected']);
      List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];
      for (int i = 0; i < diasDaSemana.length; i++) {
        if (dias.contains(diasDaSemana[i])) {
          _diasSelecionados[i] = true;
        }
      }
    }
  }

  void _saveChanges() async {
    String nome = _nomeController.text;
    String especialidade = _especialidadeController.text;
    String crm = _crmController.text;
    String telefone = _telefoneController.text;
    String observacoes = _observacoesController.text;

    bool isPresencial = _consultaPresencial;
    bool isOnline = _consultaOnline;

    List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];
    List<String> diasSelecionados = [];
    for (int i = 0; i < _diasSelecionados.length; i++) {
      if (_diasSelecionados[i]) diasSelecionados.add(diasDaSemana[i]);
    }

    try {
      await FirebaseFirestore.instance
          .collection('medicos')
          .doc(widget.docId)
          .update({
        'name': nome,
        'specialty': especialidade,
        'crm': crm,
        'phone': telefone,
        'observations': observacoes,
        'isPresencial': isPresencial,
        'isOnline': isOnline,
        'daysSelected': diasSelecionados,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alterações salvas com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar alterações: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Médico'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _especialidadeController,
              decoration: const InputDecoration(labelText: 'Especialidade'),
            ),
            TextField(
              controller: _crmController,
              decoration: const InputDecoration(labelText: 'CRM/RQE'),
            ),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            SwitchListTile(
              title: const Text('Consulta Presencial'),
              value: _consultaPresencial,
              onChanged: (value) {
                setState(() {
                  _consultaPresencial = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Consulta Online'),
              value: _consultaOnline,
              onChanged: (value) {
                setState(() {
                  _consultaOnline = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Dias de Atendimento',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab']
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key;
                String dia = entry.value;
                return FilterChip(
                  label: Text(dia),
                  selected: _diasSelecionados[index],
                  onSelected: (selected) {
                    setState(() {
                      _diasSelecionados[index] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _observacoesController,
              decoration: const InputDecoration(labelText: 'Observações'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
