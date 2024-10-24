import 'package:flutter/material.dart';

class RegisterDoctorScreen extends StatefulWidget {
  const RegisterDoctorScreen({Key? key}) : super(key: key);

  @override
  _RegisterDoctorScreenState createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Inicialmente todas as checkboxes são false (não marcadas)
  bool _isPresencial = false;
  bool _isOnline = false;
  List<bool> _daysSelected = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Médico'),
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

              // Especialidade
              _buildTextField('Especialidade'),
              const SizedBox(height: 16.0),

              // CRM/RQE
              _buildTextField('CRM/RQE'),
              const SizedBox(height: 16.0),

              // Telefone
              _buildTextField('Telefone', hintText: '(00) 91234-5678'),
              const SizedBox(height: 16.0),

              // Tipos de Consulta
              const Text(
                'Tipos de Consulta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 24, 108, 80)),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isPresencial,
                    activeColor: const Color.fromARGB(255, 24, 108, 80), // Cor da checkbox
                    onChanged: (bool? value) {
                      setState(() {
                        _isPresencial = value!;
                      });
                    },
                  ),
                  const Text('Presencial'),
                  Checkbox(
                    value: _isOnline,
                    activeColor: const Color.fromARGB(255, 24, 108, 80), // Cor da checkbox
                    onChanged: (bool? value) {
                      setState(() {
                        _isOnline = value!;
                      });
                    },
                  ),
                  const Text('Online'),
                ],
              ),
              const SizedBox(height: 16.0),

              // Dias de Atendimento
              const Text(
                'Dias de atendimento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 24, 108, 80)),
              ),
              Wrap(
                spacing: 10.0,
                children: [
                  _buildDayCheckBox('SEG', 0),
                  _buildDayCheckBox('TER', 1),
                  _buildDayCheckBox('QUA', 2),
                  _buildDayCheckBox('QUI', 3),
                  _buildDayCheckBox('SEX', 4),
                  _buildDayCheckBox('SAB', 5),
                ],
              ),
              const SizedBox(height: 16.0),

              // Observações
              _buildTextField('Observações (opcional)', maxLines: 3),
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

  // Função para criar Checkboxes de dias
  Widget _buildDayCheckBox(String label, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _daysSelected[index],
          activeColor: const Color.fromARGB(255, 24, 108, 80), // Cor da checkbox
          onChanged: (bool? value) {
            setState(() {
              _daysSelected[index] = value!;
            });
          },
        ),
        Text(label),
      ],
    );
  }
}
