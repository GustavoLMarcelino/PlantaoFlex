import 'package:flutter/material.dart';

class EditCliScreen extends StatefulWidget {
  final Map<String, dynamic> cliente;

  const EditCliScreen({Key? key, required this.cliente}) : super(key: key);

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditCliScreen> {
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
    _nascimentoController = TextEditingController(text: widget.cliente['nascimento']);
    _telefoneController = TextEditingController(text: widget.cliente['telefone']);
    _cpfController = TextEditingController(text: widget.cliente['cpf']);
    _rgController = TextEditingController(text: widget.cliente['rg']);
    _emailController = TextEditingController(text: widget.cliente['email']);
    _observacoesController = TextEditingController(text: widget.cliente['observacoes']);
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
              // Campo de Nome
              _buildTextField(_nomeController, 'Nome'),
              const SizedBox(height: 16.0),

              // Campo de Data de Nascimento
              _buildTextField(_nascimentoController, 'Data de Nascimento', hintText: 'DD/MM/AAAA'),
              const SizedBox(height: 16.0),

              // Campo de Telefone
              _buildTextField(_telefoneController, 'Telefone'),
              const SizedBox(height: 16.0),

              // Campo de CPF
              _buildTextField(_cpfController, 'CPF'),
              const SizedBox(height: 16.0),

              // Campo de RG
              _buildTextField(_rgController, 'RG'),
              const SizedBox(height: 16.0),

              // Campo de Email
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 16.0),

              // Campo de Observações (opcional)
              _buildTextField(_observacoesController, 'Observações (opcional)', maxLines: 3),
              const SizedBox(height: 32.0),

              // Botões Cancelar e Salvar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botão Cancelar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Botão Salvar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: const Color.fromARGB(255, 24, 108, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showConfirmSaveDialog(); // Exibe o diálogo de confirmação ao salvar
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar campos de texto personalizados
  Widget _buildTextField(TextEditingController controller, String labelText, {String? hintText, int maxLines = 1}) {
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

  // Função para exibir o diálogo de confirmação ao salvar
  void _showConfirmSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salvar alterações?'),
          content: const Text('Tem certeza de que deseja salvar as alterações?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo sem salvar
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                _saveChanges(); // Salva as alterações
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Função para salvar as alterações
  void _saveChanges() {
    // Coleta os dados preenchidos
    String nome = _nomeController.text;
    String nascimento = _nascimentoController.text;
    String telefone = _telefoneController.text;
    String cpf = _cpfController.text;
    String rg = _rgController.text;
    String email = _emailController.text;
    String observacoes = _observacoesController.text;

    // Simula salvamento (você pode adicionar lógica para salvar em banco de dados ou outras operações)
    print('Nome: $nome');
    print('Data de Nascimento: $nascimento');
    print('Telefone: $telefone');
    print('CPF: $cpf');
    print('RG: $rg');
    print('Email: $email');
    print('Observações: $observacoes');

    // Após salvar, retorna à tela anterior
    Navigator.pop(context);
  }
}
