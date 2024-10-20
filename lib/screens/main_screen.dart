import 'package:flutter/material.dart';
import 'usercentral_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlantãoFlex'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        automaticallyImplyLeading: false, // Remove a seta padrão de retorno
        leading: IconButton( // Ícone de menu (três linhas)
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Ação para abrir o menu pode ser definida aqui
          },
        ),
        actions: [
          // Ícone de usuário na extrema direita
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo horizontalmente
          children: <Widget>[
            // Espaçamento controlado entre o AppBar e o texto "Bem-vindo, [user]!"
            const SizedBox(height: 80), // Ajuste este valor para mover o título mais próximo ou mais distante do AppBar
            const Text(
              'Bem-vindo, [user]!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 0), // Espaçamento entre o título e os botões

            // Botões de Menu (Usando ElevatedButton)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões verticalmente na parte restante
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildMenuButton(context, 'Consultar Médicos'),
                  _buildMenuButton(context, 'Consultar Clientes'),
                  _buildMenuButton(context, 'Cadastrar novo Médico'),
                  _buildMenuButton(context, 'Cadastrar nova Consulta'),
                  _buildMenuButton(context, 'Cadastrar novo Cliente'),
                  _buildMenuButton(context, 'Dashboards e Relatórios'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir botões de menu
  Widget _buildMenuButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity, // Largura máxima possível (preenche toda a tela)
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15), // Definir padding apenas para a altura
            backgroundColor: const Color.fromARGB(255, 4, 96, 65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // Botões arredondados
            ),
          ),
          onPressed: () {
            // Ação de cada botão pode ser definida aqui
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}