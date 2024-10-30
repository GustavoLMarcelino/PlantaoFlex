import 'package:flutter/material.dart';

class CadastroConsultScreen extends StatefulWidget {
  const CadastroConsultScreen({Key? key}) : super(key: key);

  @override
  _CadastroConsultaScreenState createState() => _CadastroConsultaScreenState();
}

class _CadastroConsultaScreenState extends State<CadastroConsultScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Consulta'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Data da Consulta
              _buildTextField('Data da Consulta', hintText: 'DD/MM/AAAA'),
              const SizedBox(height: 16.0),

              // Médico
              _buildTextField('Médico'),
              const SizedBox(height: 16.0),

              // Especialidade
              _buildTextField('Especialidade'),
              const SizedBox(height: 16.0),

              // Paciente
              _buildTextField('Paciente'),
              const SizedBox(height: 16.0),

              // Data de Retorno (opcional)
              _buildTextField('Data de Retorno (opcional)', hintText: 'DD/MM/AAAA'),
              const SizedBox(height: 16.0),

              // Valor da Consulta
              _buildTextField('Valor da Consulta', prefixText: 'R\$'),
              const SizedBox(height: 16.0),

              // Valor a ser pago ao médico
              _buildTextField('Valor a ser pago ao médico', prefixText: 'R\$'),
              const SizedBox(height: 16.0),

              // Observações (opcional)
              _buildTextField('Observações (opcional)', maxLines: 3),
              const SizedBox(height: 32.0),

              // Botões Cancelar e Salvar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: const Color.fromARGB(255, 1, 118, 115),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Ação de salvar
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

  // Função para criar TextFields personalizados
  Widget _buildTextField(String labelText, {String? hintText, String? prefixText, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixText: prefixText,
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
}
