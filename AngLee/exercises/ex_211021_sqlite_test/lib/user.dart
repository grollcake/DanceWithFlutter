class User {
  final int idx;
  final String id;
  final String name;
  final int age;

  User({
    required this.idx,
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'idx': idx,
      'id': id,
      'name': name,
      'age': age,
    };
  }
}