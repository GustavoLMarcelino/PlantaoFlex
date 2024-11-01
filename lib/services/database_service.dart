import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantaoflex/models/medico.dart';

const String MEDICO_COLLECTION_REF = "medicos";
const String PACIENTE_COLLECTION_REF = "pacientes";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _medicosRef;

  DatabaseService() {
    _medicosRef =
        _firestore.collection(MEDICO_COLLECTION_REF).withConverter<Medico>(
            fromFirestore: (snapshots, _) => Medico.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (medico, _) => medico.toJson());
  }

  Stream<QuerySnapshot> getMedicos() {
    return _medicosRef.snapshots();
  }

  void addMedico(Medico medico) async {
    _medicosRef.add(medico);
  }
}
