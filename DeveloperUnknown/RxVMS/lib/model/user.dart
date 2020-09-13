class User {
  final String name;
  final String image;
  final String email;

  User({this.email, this.image, this.name});

  User.fromJson(Map<String, dynamic> j) :
    name = j["name"]["first"] + " " + j["name"]["last"],
    image = j["picture"]['medium'],
    email = j["email"];    
}