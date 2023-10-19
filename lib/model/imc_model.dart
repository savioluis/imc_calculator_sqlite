import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImcModel {
  int id;
  double valor;
  String categoria;
  String nome;
  double peso;
  double altura;

  ImcModel({
    required this.id,
    required this.valor,
    required this.categoria,
    required this.nome,
    required this.peso,
    required this.altura,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'valor': valor,
      'categoria': categoria,
      'nome': nome,
      'peso': peso,
      'altura': altura,
    };
  }

  factory ImcModel.fromMap(Map<String, dynamic> map) {
    return ImcModel(
      id: map['id'] as int,
      valor: map['valor'] as double,
      categoria: map['categoria'] as String,
      nome: map['nome'] as String,
      peso: map['peso'] as double,
      altura: map['altura'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImcModel.fromJson(String source) =>
      ImcModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImcModel(id: $id, valor: $valor, categoria: $categoria, nome: $nome, peso: $peso, altura: $altura)';
  }
}
