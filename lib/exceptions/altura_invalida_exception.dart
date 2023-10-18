class AlturaInvalidaException implements Exception {
  final String message;

  AlturaInvalidaException({this.message = "Altura inválida"});

  @override
  String toString() {
    return "AlturaInvalidaException: $message";
  }
}
