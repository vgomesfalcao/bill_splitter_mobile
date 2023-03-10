class User {
  final String username;
  final String name;
  final String password;

  User(this.username, this.name, this.password);

  @override
  String toString() {
    return username;
  }
}
