import 'package:flutter/material.dart';

class Medico {
  String nome;
  String crmRqe;
  Map<String, bool> consulta = {
    'online': false,
    'presencial': false,
  };
  Map<String, bool> diasAtend = {
    'domingo': false,
    'segunda': false,
    'terca': false,
    'quarta': false,
    'quinta': false,
    'sexta': false,
    'sabado': false,
  };
  String telefone;
  String observacoes;

  Medico({
    required this.nome,
    required this.crmRqe,
    required this.telefone,
    required this.observacoes,
  });

  Medico.fromJson(Map<String, Object?> json)
      : this(
          nome: json['nome']! as String,
          crmRqe: json['crmRqe']! as String,
          telefone: json['telefone']! as String,
          observacoes: json['observacoes']! as String,
        );

  Medico copyWith({
    String? nome,
    String? crmRqe,
    String? telefone,
    String? observacoes,
  }) {
    return Medico(
      nome: nome ?? this.nome,
      crmRqe: crmRqe ?? this.crmRqe,
      telefone: telefone ?? this.telefone,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'crmRqe': crmRqe,
      'telefone': telefone,
      'observacoes': observacoes,
    };
  }
}
