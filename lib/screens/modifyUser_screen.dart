import 'package:flutter/material.dart';

class ModifyuserScreen extends StatelessWidget {
  const ModifyuserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlantãoFlex'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: true, // Mostra o botão "voltar"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da seção
            const Text(
              'Dados pessoais',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 108, 80),
              ),
            ),
            const SizedBox(height: 20),

            // Nome
            _buildInfoRow('Nome', 'Arthur Henrique Maia'),
            const SizedBox(height: 10),

            // Data de Nascimento
            _buildInfoRow('Data de Nascimento', '13/05/1977'),
            const SizedBox(height: 10),

            // Telefone
            _buildInfoRow('Telefone', '(47) 98845-6789'),
            const SizedBox(height: 10),

            // E-mail
            _buildInfoRow('Email', 'arthurmaia@hotmail.com'),
            const SizedBox(height: 10),

            // Senha
            _buildInfoRow('Senha', '***********'),
            const SizedBox(height: 20),

            // Botões para edição (nome, telefone, e-mail, senha)
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar os campos de exibição de dados do usuário
  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Função para criar os botões de edição de dados
  Widget _buildEditButton(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route); // Navegar para a tela de edição correspondente
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 24, 108, 80),
        ),
      ),
    );
  }
}
