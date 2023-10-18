class NomeInvalidoException implements Exception {
  final String message;

  NomeInvalidoException({this.message = "Nome inválido"});

  @override
  String toString() {
    return "NomeInvalidoException: $message";
  }
}
