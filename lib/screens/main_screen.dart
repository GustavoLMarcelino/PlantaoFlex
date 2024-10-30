import 'package:flutter/material.dart';

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
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navega para a tela de perfil do usuário
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 24, 108, 80),
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
                  const SnackBar(
                      content: Text('Indo para Perguntas Frequentes')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Desconectar'),
              onTap: () {
                // Navegar para a página de login usando rota nomeada
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 80),
            const Text(
              'Bem-vindo, [user]!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 108, 80),
              ),
            ),
            const SizedBox(height: 0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _buildMenuButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: const Color.fromARGB(255, 24, 108, 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            if (text == 'Consultar Médicos') {
              Navigator.pushNamed(context, '/search-doctor');
            }
            if (text == 'Consultar Clientes') {
              Navigator.pushNamed(context, '/search-client');
            }
            if (text == 'Cadastrar novo Médico') {
              Navigator.pushNamed(context, '/register-doctor');
            }
            if (text == 'Cadastrar nova Consulta') {
              Navigator.pushNamed(context, '/register-consult');
            }
            if (text == 'Cadastrar novo Cliente') {
              Navigator.pushNamed(context, '/register-client');
            }
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
