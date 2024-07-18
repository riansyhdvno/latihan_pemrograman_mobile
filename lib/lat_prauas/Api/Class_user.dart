class User {
  final int id;
  final String fullname;
  final String username;
  final String email;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      email: json['email'],
    );
  }
}
