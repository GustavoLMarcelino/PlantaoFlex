import 'package:flutter/material.dart';

void main() {
  runApp(const PlantaoFlexApp());
}

class PlantaoFlexApp extends StatelessWidget {
  const PlantaoFlexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SuporteScreen(),
    );
  }
}

class SuporteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'PlantãoFlex',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Ação para fechar ou sair
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Para suporte adicional, entre\nem contato pelo Whatsapp\n(47) 91234-6789 ou envie um\nemail para plantao@flex.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 24, 108, 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
