import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantaoflex/screens/main_screen.dart';

class RegisterAppointmentScreen extends StatefulWidget {
  const RegisterAppointmentScreen({Key? key}) : super(key: key);

  @override
  _RegisterAppointmentScreenState createState() =>
      _RegisterAppointmentScreenState();
}

class _RegisterAppointmentScreenState extends State<RegisterAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variáveis para armazenar dados da consulta
  String? _selectedDoctorId;
  String? _selectedPatientId;
  String? _appointmentDate;
  String? _appointmentTime;
  double? _fee;

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
              // Selecionar Médico
              const Text(
                'Selecione o Médico',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('medicos')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final doctors = snapshot.data!.docs;
                  return DropdownButtonFormField<String>(
                    items: doctors.map((doc) {
                      return DropdownMenuItem<String>(
                        value: doc.id,
                        child: Text(doc['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDoctorId = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Por favor, selecione um médico' : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),

              // Selecionar Paciente
              const Text(
                'Selecione o Paciente',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pacientes')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final patients = snapshot.data!.docs;
                  return DropdownButtonFormField<String>(
                    items: patients.map((doc) {
                      return DropdownMenuItem<String>(
                        value: doc.id,
                        child: Text(doc['nome']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPatientId = value;
                      });
                    },
                    validator: (value) => value == null
                        ? 'Por favor, selecione um paciente'
                        : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),

              // Data da Consulta
              _buildTextField('Data da Consulta',
                  hintText: 'DD/MM/AAAA',
                  onSaved: (value) => _appointmentDate = value),
              const SizedBox(height: 16.0),

              // Hora da Consulta
              _buildTextField('Hora da Consulta',
                  hintText: 'HH:MM',
                  onSaved: (value) => _appointmentTime = value),
              const SizedBox(height: 16.0),

              // Valor da Consulta
              _buildTextField('Valor da Consulta',
                  hintText: 'Ex: 150.00',
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _fee = double.tryParse(value ?? '')),
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
                    onPressed: _saveAppointment,
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

  Widget _buildTextField(String labelText,
      {String? hintText,
      TextInputType keyboardType = TextInputType.text,
      FormFieldSetter<String>? onSaved}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha o campo $labelText';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final appointmentData = {
        'doctorId': _selectedDoctorId,
        'patientId': _selectedPatientId,
        'appointmentDate': _appointmentDate,
        'appointmentTime': _appointmentTime,
        'fee': _fee,
      };

      try {
        await FirebaseFirestore.instance
            .collection('consultas')
            .add(appointmentData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Consulta cadastrada com sucesso!')),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar consulta: $e')),
        );
      }
    }
  }
}
