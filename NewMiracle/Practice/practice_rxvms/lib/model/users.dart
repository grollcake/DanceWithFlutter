class User{

  final String name;
  final String email;
  final String picture;

  User({this.name, this.email, this.picture});

  User.fromJson(Map<String, dynamic> json) :
      name = json['name']['first'] + ' ' + json['name']['last'],
      email = json['email'],
      picture = json['picture']['medium'];

  @override
  String toString() {
    return name + '(' + email + ')';
  }
}