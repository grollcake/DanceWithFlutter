import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String image;

  User({this.email, this.image, this.name});

  User.fromJson(Map<String, dynamic> j) : //String : key, dynamic : value
    email = j["email"],
    name = j["name"]["first"] + " " + j["name"]["last"],
    image = j["picture"]["medium"]
  ;

  String toString() {
    return name + "(" + email + ")";
  }
}