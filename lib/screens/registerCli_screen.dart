import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantaoflex/screens/main_screen.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({Key? key}) : super(key: key);

  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final _formKey = GlobalKey<FormState>();

  // Campos do formulário
  String? _nome;
  String? _dataNascimento;
  String? _telefone;
  String? _cpf;
  String? _rg;
  String? _email;
  String? _observacoes;

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
              _buildTextField('Nome', onSaved: (value) => _nome = value),
              const SizedBox(height: 16.0),

              // Data de Nascimento
              _buildTextField('Data de Nascimento',
                  hintText: 'DD/MM/AAAA',
                  onSaved: (value) => _dataNascimento = value),
              const SizedBox(height: 16.0),

              // Telefone
              _buildTextField('Telefone',
                  hintText: '(00) 91234-5678',
                  onSaved: (value) => _telefone = value),
              const SizedBox(height: 16.0),

              // CPF
              _buildTextField('CPF',
                  hintText: '123.456.789.00', onSaved: (value) => _cpf = value),
              const SizedBox(height: 16.0),

              // RG
              _buildTextField('RG',
                  hintText: '12.345.689.90', onSaved: (value) => _rg = value),
              const SizedBox(height: 16.0),

              // Email
              _buildTextField('Email',
                  hintText: 'john@doe.com', onSaved: (value) => _email = value),
              const SizedBox(height: 16.0),

              // Observações (opcional)
              _buildTextField('Observações (opcional)',
                  maxLines: 5, onSaved: (value) => _observacoes = value),
              const SizedBox(height: 32.0),

              // Botões Cancelar e Salvar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botão Cancelar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: const Color.fromARGB(255, 24, 108, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!
                            .save(); // Salva os valores dos campos

                        // Cria um mapa com os dados do cliente
                        final clientData = {
                          'nome': _nome,
                          'nascimento': _dataNascimento,
                          'telefone': _telefone,
                          'cpf': _cpf,
                          'rg': _rg,
                          'email': _email,
                          'observacoes': _observacoes,
                        };

                        try {
                          // Adiciona os dados do cliente à coleção 'pacientes'
                          await FirebaseFirestore.instance
                              .collection('pacientes')
                              .add(clientData);

                          // Mostra uma mensagem de sucesso
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Cliente cadastrado com sucesso!')),
                          );

                          // Navega para a MainScreen e remove as telas anteriores da pilha
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainScreen()), // Rota para a MainScreen
                            (Route<dynamic> route) =>
                                false, // Remove todas as rotas anteriores
                          );
                        } catch (e) {
                          // Tratar erros
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Erro ao cadastrar cliente: $e')),
                          );
                        }
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
  Widget _buildTextField(String labelText,
      {String? hintText, int maxLines = 1, FormFieldSetter<String>? onSaved}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if ((value == null || value.isEmpty) &&
            labelText != 'Observações (opcional)') {
          return 'Por favor, preencha o campo $labelText';
        }
        return null;
      },
      onSaved: onSaved, // Salva o valor do campo
    );
  }
}
