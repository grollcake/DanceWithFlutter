class User {
  final String name;
  final String email;
  final String image;

  User({this.email, this.image, this.name});

  User.fromJson(Map<String, dynamic> j) :
    name = j["name"]["first"] + " " + j["name"]["last"],
    email = j["email"],
    image = j["picture"]["medium"];
}