import 'package:flutter/material.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({Key? key}) : super(key: key);

  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
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
              // Nome
              _buildTextField('Nome'),
              const SizedBox(height: 16.0),

              // Data de Nascimento
              _buildTextField('Data de Nascimento', hintText: 'DD/MM/AAAA'),
              const SizedBox(height: 16.0),

              // Telefone
              _buildTextField('Telefone', hintText: '(00) 91234-5678'),
              const SizedBox(height: 16.0),

              // CPF
              _buildTextField('CPF', hintText: '123.456.789.00'),
              const SizedBox(height: 16.0),

              // RG
              _buildTextField('RG', hintText: '12.345.689.90'),
              const SizedBox(height: 16.0),

              // Email
              _buildTextField('Email', hintText: 'john@doe.com'),
              const SizedBox(height: 16.0),

              // Observações (opcional)
              _buildTextField('Observações (opcional)', maxLines: 5),
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
  Widget _buildTextField(String labelText, {String? hintText, int maxLines = 1}) {
    return TextFormField(
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
}
