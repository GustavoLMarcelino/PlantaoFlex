import 'package:flutter/material.dart';
import 'package:plantaoflex/screens/login_screen.dart' as login;
import 'package:plantaoflex/screens/main_screen.dart';
import 'package:plantaoflex/screens/registerCli_screen.dart' as register;
import 'package:plantaoflex/screens/registerMed_screen.dart';
import 'package:plantaoflex/screens/searchMed_screen.dart';
import 'package:plantaoflex/screens/searchCli_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlantãoFlex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 176, 70, 62)),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define a rota inicial como o LoginScreen
      routes: {
        '/': (context) => const login.LoginScreen(
title: 'Login'), // Prefixo aplicado ao LoginScreen
        '/main': (context) => const MainScreen(), // Página principal
        '/register-client': (context) => register.RegisterClientScreen(), // Prefixo aplicado ao RegisterClientScreen
        '/register-doctor': (context) => const RegisterDoctorScreen(), // Cadastro de médico
        '/search-doctor': (context) => const SearchMedScreen(), // Consultar Médico
        '/search-client': (context) => const SearchClientScreen(), // Consultar cliente
      },
    );
  }
}
