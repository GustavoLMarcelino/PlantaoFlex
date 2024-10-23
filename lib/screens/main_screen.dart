import 'package:flutter/material.dart';
import 'package:plantaoflex/screens/login_screen.dart';

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Abre o menu lateral da esquerda
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          // Ícone de usuário na extrema direita
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Ação do ícone de usuário pode ser definida aqui
            },
          ),
        ],
      ),
      // Menu lateral (Drawer) que abre pela esquerda
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 118, 115),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Suporte'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Indo para Suporte')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Perguntas Frequentes'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Indo para Perguntas Frequentes')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Desconectar'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(title: 'Login'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo horizontalmente
          children: <Widget>[
            const SizedBox(height: 80), // Ajuste para controlar o espaçamento
            const Text(
              'Bem-vindo, [user]!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 118, 115),
              ),
            ),
            const SizedBox(height: 0), // Espaçamento entre o título e os botões
            // Botões de Menu (Usando ElevatedButton)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões verticalmente
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
            backgroundColor: const Color.fromARGB(255, 1, 118, 115),
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
