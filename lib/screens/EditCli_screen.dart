import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCliScreen extends StatefulWidget {
  final Map<String, dynamic> cliente;
  final String docId; // Adicionado o parâmetro docId

  const EditCliScreen({
    Key? key,
    required this.cliente,
    required this.docId, // Torna obrigatório passar o docId
  }) : super(key: key);

  @override
  _EditCliScreenState createState() => _EditCliScreenState();
}

class _EditCliScreenState extends State<EditCliScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos de texto
  late TextEditingController _nomeController;
  late TextEditingController _nascimentoController;
  late TextEditingController _telefoneController;
  late TextEditingController _cpfController;
  late TextEditingController _rgController;
  late TextEditingController _emailController;
  late TextEditingController _observacoesController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.cliente['nome']);
    _nascimentoController =
        TextEditingController(text: widget.cliente['nascimento']);
    _telefoneController =
        TextEditingController(text: widget.cliente['telefone']);
    _cpfController = TextEditingController(text: widget.cliente['cpf']);
    _rgController = TextEditingController(text: widget.cliente['rg']);
    _emailController = TextEditingController(text: widget.cliente['email']);
    _observacoesController =
        TextEditingController(text: widget.cliente['observacoes']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nomeController, 'Nome'),
              const SizedBox(height: 16.0),
              _buildTextField(_nascimentoController, 'Data de Nascimento',
                  hintText: 'DD/MM/AAAA'),
              const SizedBox(height: 16.0),
              _buildTextField(_telefoneController, 'Telefone'),
              const SizedBox(height: 16.0),
              _buildTextField(_cpfController, 'CPF'),
              const SizedBox(height: 16.0),
              _buildTextField(_rgController, 'RG'),
              const SizedBox(height: 16.0),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 16.0),
              _buildTextField(_observacoesController, 'Observações (opcional)',
                  maxLines: 3),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 24, 108, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: _saveChanges,
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {String? hintText, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha o campo $labelText';
        }
        return null;
      },
    );
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Atualizando o documento no Firestore
        await FirebaseFirestore.instance
            .collection('pacientes') // Nome da coleção
            .doc(widget.docId) // Identificador do documento
            .update({
          'nome': _nomeController.text,
          'nascimento': _nascimentoController.text,
          'telefone': _telefoneController.text,
          'cpf': _cpfController.text,
          'rg': _rgController.text,
          'email': _emailController.text,
          'observacoes': _observacoesController.text,
        });

        // Mostra um snackbar ao salvar com sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alterações salvas com sucesso!')),
        );

        // Voltar para a tela anterior
        Navigator.pop(context);
      } catch (e) {
        // Mostra um snackbar com a mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    }
  }
}
