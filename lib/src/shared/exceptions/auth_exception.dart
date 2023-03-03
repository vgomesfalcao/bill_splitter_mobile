class AuthException implements Exception {
  final Map<int, String> errors = {
    404: 'Não encontrado',
    401: 'Precisa logar para acessar esse recurso',
  };
  final int statusCode;

  AuthException(this.statusCode);

  @override
  String toString() {
    return errors[statusCode] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
