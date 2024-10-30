import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  cadastrarUsuario({
    required String email,
    required String senha,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }

  Future<User?> logarUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return cred.user;
    } catch (e) {
      print("Erro no login");
    }
    return null;
  }

  Future<void> deslogarUsuario() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Erro no logout");
    }
    ;
  }
}
