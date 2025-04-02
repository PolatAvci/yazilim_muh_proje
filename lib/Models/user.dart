class User {
  int id;
  String name;
  String surname;
  String username;
  String email;
  String password;
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
