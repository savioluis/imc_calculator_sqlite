class PesoInvalidoException implements Exception {
  final String message;

  PesoInvalidoException({this.message = "Peso inválido"});

  @override
  String toString() {
    return "PesoInvalidoException: $message";
  }
}
