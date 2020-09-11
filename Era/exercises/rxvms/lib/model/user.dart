class User {
  final String name;
  final String email;
  final String picture;

  User({this.name, this.email, this.picture});

  User.fromJson(Map<String, dynamic> j) :
      name = j['name']['first'] + ' ' + j['name']['last'],
      email = j['email'],
  picture = j['picture']['medium'];

  @override
  String toString() => '$name ($email)';

}