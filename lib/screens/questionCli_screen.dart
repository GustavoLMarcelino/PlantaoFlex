import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Center(
          child: Text(
            'PlantãoFlex',
            style: TextStyle(color: Colors.black),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // Espaçamento lateral e no topo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
          children: [
            _buildFAQItem(
              '1. Esqueci minha senha. Como recupero minha conta?',
              'R: Vá para a central do usuário e siga as instruções para a mudança de sua senha.',
            ),
            const SizedBox(height: 30), // Espaçamento entre os itens
            _buildFAQItem(
              '2. Como faço para mudar o email da minha conta?',
              'R: Vá para a central do usuário e siga as instruções para a mudança de seu email.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 24, 108, 80),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          answer,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
