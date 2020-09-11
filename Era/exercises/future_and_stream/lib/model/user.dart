class User {
  final String name;
  final String email;
  final String picture;

  User({this.name, this.email, this.picture});

  @override
  String toString() {
    return '${this.name} (${this.email})';
  }
}