import 'package:flutter/material.dart';
import 'modifyUser_screen.dart'; // Certifique-se de que essa tela está correta e implementada

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlantãoFlex'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem do perfil (círculo) centralizada e maior
            const CircleAvatar(
              radius: 70, // Aumentando o tamanho do ícone
              backgroundImage: AssetImage('assets/profile_pic.png'), // Substitua pelo caminho da imagem
            ),
            const SizedBox(height: 20),
            
            // Texto de boas-vindas centralizado
            const Text(
              'Bem-vindo,\nArthur Henrique Maia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24, // Maior tamanho do texto
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 108, 80),
              ),
            ),
            const SizedBox(height: 30),

            // Sessão "Seus dados" centralizada
            const Text(
              'Seus dados',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, // Aumentado o tamanho
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 108, 80),
              ),
            ),
            const SizedBox(height: 30),
            
            // Informações do usuário alinhadas à esquerda
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Nome', 'Arthur Henrique Maia'),
                  const SizedBox(height: 10),
                  _buildInfoRow('Data de Nascimento', '13/05/1977'),
                  const SizedBox(height: 10),
                  _buildInfoRow('Telefone', '(47) 98845-6789'),
                  const SizedBox(height: 10),
                  _buildInfoRow('Email', 'arthurmaia@hotmail.com'),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // Botões para modificar dados, agora alinhados à esquerda
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      // Função para modificar foto de perfil
                    },
                    child: const Text(
                      'Modificar foto de perfil',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 24, 108, 80),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navegar para a tela de modificar dados pessoais
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ModifyuserScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Modificar dados pessoais',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 24, 108, 80),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar linhas de informações do perfil
  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
}
