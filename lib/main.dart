import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlataoFlex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 176, 70, 62)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Imagem centralizada
            Image.asset(
              'images/logo_plantaoFlex.png', // Substitua pelo caminho correto
              width: 170,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30), // Espaçamento entre a imagem e o texto "LOGIN"

            // Texto "LOGIN"
            const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 164, 192), // Cor verde escuro
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 30), // Espaçamento entre o texto "LOGIN" e o campo de e-mail

            // Campo de texto para e-mail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Digite seu e-mail',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.email, color: Color.fromARGB(255, 22, 169, 174)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromARGB(255, 22, 169, 174)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromARGB(255, 22, 169, 174), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campo de texto para senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 22, 169, 174)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromARGB(255, 22, 169, 174)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromARGB(255, 22, 169, 174), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40), // Espaçamento entre os campos e o botão

            // Botão "Entrar"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: const Color.fromARGB(255, 22, 169, 174),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()), // Navegação para o Menu
                );
              },
              child: const Text(
                'Entrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Menu Principal 
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlantãoFlex'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 169, 174),
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
                color: Color(0xFF004D40), // Cor verde escuro
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
            backgroundColor: const Color.fromARGB(255, 22, 169, 174),
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
