import 'package:flutter/material.dart';

class EditMedScreen extends StatefulWidget {
  final Map<String, dynamic> medico;

  const EditMedScreen({Key? key, required this.medico}) : super(key: key);

  @override
  _EditMedicoScreenState createState() => _EditMedicoScreenState();
}

class _EditMedicoScreenState extends State<EditMedScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos de texto
  late TextEditingController _nomeController;
  late TextEditingController _especialidadeController;
  late TextEditingController _crmController;
  late TextEditingController _telefoneController;
  late TextEditingController _observacoesController;

  // Variáveis para os checkboxes
  bool _consultaPresencial = false;
  bool _consultaOnline = false;
  List<bool> _diasSelecionados = [false, false, false, false, false, false]; // SEG, TER, QUA, QUI, SEX, SAB

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.medico['nome']);
    _especialidadeController = TextEditingController(text: widget.medico['especialidade']);
    _crmController = TextEditingController(text: widget.medico['crm']);
    _telefoneController = TextEditingController(text: widget.medico['telefone']);
    _observacoesController = TextEditingController(text: widget.medico['observacoes']);
    
    // Configura os checkboxes com base nos dados iniciais
    _consultaPresencial = widget.medico['consulta'].contains('Presencial');
    _consultaOnline = widget.medico['consulta'].contains('Online');

    // Definindo os dias selecionados
    final dias = widget.medico['dias'].split(' | ');
    List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];
    for (int i = 0; i < diasDaSemana.length; i++) {
      if (dias.contains(diasDaSemana[i])) {
        _diasSelecionados[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Médico'),
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

              // Campo de Especialidade
              _buildTextField(_especialidadeController, 'Especialidade'),
              const SizedBox(height: 16.0),

              // Campo de CRM
              _buildTextField(_crmController, 'CRM/RQE'),
              const SizedBox(height: 16.0),

              // Campo de Telefone
              _buildTextField(_telefoneController, 'Telefone'),
              const SizedBox(height: 16.0),

              // Título para Tipos de Consulta
              const Text(
                'Tipos de Consulta',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18),
              ),
              const SizedBox(height: 8.0),

              // Checkboxes para Tipos de Consulta
              Row(
                children: [
                  Checkbox(
                    value: _consultaPresencial,
                    onChanged: (value) {
                      setState(() {
                        _consultaPresencial = value!;
                      });
                    },
                  ),
                  const Text('Presencial'),
                  Checkbox(
                    value: _consultaOnline,
                    onChanged: (value) {
                      setState(() {
                        _consultaOnline = value!;
                      });
                    },
                  ),
                  const Text('Online'),
                ],
              ),
              const SizedBox(height: 16.0),

              // Título para Dias de Atendimento
              const Text(
                'Dias de atendimento',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18),
              ),
              const SizedBox(height: 8.0),

              // Checkboxes para Dias de Atendimento
              Wrap(
                spacing: 10.0,
                children: List<Widget>.generate(6, (index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _diasSelecionados[index],
                        onChanged: (value) {
                          setState(() {
                            _diasSelecionados[index] = value!;
                          });
                        },
                      ),
                      Text(['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'][index]),
                    ],
                  );
                }),
              ),
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
  Widget _buildTextField(TextEditingController controller, String labelText, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
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
    String especialidade = _especialidadeController.text;
    String crm = _crmController.text;
    String telefone = _telefoneController.text;
    String observacoes = _observacoesController.text;

    // Coleta os tipos de consulta selecionados
    String tiposConsulta = '';
    if (_consultaPresencial) tiposConsulta += 'Presencial';
    if (_consultaOnline) tiposConsulta += tiposConsulta.isNotEmpty ? ' | Online' : 'Online';

    // Coleta os dias selecionados
    List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];
    String diasSelecionados = '';
    for (int i = 0; i < _diasSelecionados.length; i++) {
      if (_diasSelecionados[i]) {
        diasSelecionados += diasSelecionados.isNotEmpty ? ' | ${diasDaSemana[i]}' : diasDaSemana[i];
      }
    }

    // Simula salvamento (você pode adicionar lógica para salvar em banco de dados ou outras operações)
    print('Nome: $nome');
    print('Especialidade: $especialidade');
    print('CRM/RQE: $crm');
    print('Telefone: $telefone');
    print('Tipos de Consulta: $tiposConsulta');
    print('Dias de atendimento: $diasSelecionados');
    print('Observações: $observacoes');

    // Após salvar, retorna à tela anterior
    Navigator.pop(context);
  }
}
