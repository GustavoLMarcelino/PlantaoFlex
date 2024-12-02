import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantaoflex/screens/main_screen.dart';

class RegisterDoctorScreen extends StatefulWidget {
  const RegisterDoctorScreen({Key? key}) : super(key: key);

  @override
  _RegisterDoctorScreenState createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variáveis para armazenar informações do médico
  String _name = '';
  String _specialty = '';
  String _crm = '';
  String _phone = '';
  String _observations = '';

  // Inicialmente todas as checkboxes são false (não marcadas)
  bool _isPresencial = false;
  bool _isOnline = false;
  List<bool> _daysSelected = [false, false, false, false, false, false];

  // Lista de nomes dos dias da semana
  final List<String> _daysOfWeek = ["SEG", "TER", "QUA", "QUI", "SEX", "SAB"];

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
              _buildTextField('Nome', (value) => _name = value!),
              const SizedBox(height: 16.0),

              // Especialidade
              _buildTextField('Especialidade', (value) => _specialty = value!),
              const SizedBox(height: 16.0),

              // CRM/RQE
              _buildTextField('CRM/RQE', (value) => _crm = value!),
              const SizedBox(height: 16.0),

              // Telefone
              _buildTextField('Telefone', (value) => _phone = value!,
                  hintText: '(00) 91234-5678'),
              const SizedBox(height: 16.0),

              // Tipos de Consulta
              const Text(
                'Tipos de Consulta',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 24, 108, 80)),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isPresencial,
                    activeColor: const Color.fromARGB(255, 24, 108, 80),
                    onChanged: (bool? value) {
                      setState(() {
                        _isPresencial = value!;
                      });
                    },
                  ),
                  const Text('Presencial'),
                  Checkbox(
                    value: _isOnline,
                    activeColor: const Color.fromARGB(255, 24, 108, 80),
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
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 24, 108, 80)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_daysOfWeek.length, (index) {
                  return _buildDayCheckBox(_daysOfWeek[index], index);
                }),
              ),
              const SizedBox(height: 16.0),

              // Observações
              _buildTextField(
                  'Observações (opcional)', (value) => _observations = value!,
                  maxLines: 3),
              const SizedBox(height: 32.0),

              // Botões Cancelar e Salvar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed:
                        _saveDoctor, // Chama a função para salvar os dados
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
  Widget _buildTextField(String labelText, Function(String?) onSaved,
      {String? hintText, int maxLines = 1}) {
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
      onSaved: onSaved, // Armazena o valor preenchido
    );
  }

  // Função para criar Checkboxes de dias com o texto em cima
  Widget _buildDayCheckBox(String label, int index) {
    return Column(
      children: [
        Text(label), // Texto do dia em cima
        Checkbox(
          value: _daysSelected[index],
          activeColor:
              const Color.fromARGB(255, 24, 108, 80), // Cor da checkbox
          onChanged: (bool? value) {
            setState(() {
              _daysSelected[index] = value!;
            });
          },
        ),
      ],
    );
  }

  // Função para salvar os dados do médico no Firestore
  Future<void> _saveDoctor() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Salva os valores dos campos

      // Converte os dias selecionados (booleanos) em strings
      final daysArray = List.generate(
        _daysSelected.length,
        (index) => _daysSelected[index] ? _daysOfWeek[index] : null,
      ).whereType<String>().toList();

      // Criando o novo médico
      Map<String, dynamic> doctorData = {
        'name': _name,
        'specialty': _specialty,
        'crm': _crm,
        'phone': _phone,
        'isPresencial': _isPresencial,
        'isOnline': _isOnline,
        'daysSelected': daysArray,
        'observations': _observations.isEmpty ? null : _observations,
      };

      try {
        // Adicionando os dados do médico à coleção 'medicos'
        await FirebaseFirestore.instance.collection('medicos').add(doctorData);

        // Mostra um diálogo ou navega para a tela principal após o sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Médico cadastrado com sucesso!')),
        );

        // Navega para a MainScreen e remove as telas anteriores da pilha
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MainScreen()), // Rota para a MainScreen
          (Route<dynamic> route) => false, // Remove todas as rotas anteriores
        );
      } catch (e) {
        // Tratar erros
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar médico: $e')),
        );
      }
    }
  }
}
