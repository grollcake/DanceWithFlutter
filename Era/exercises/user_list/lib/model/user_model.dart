class UserModel {
  final String image;
  final String name;
  final String email;

  UserModel({this.image, this.name, this.email});

  @override
  String toString() {
    return '$name ($email)';
  }
}