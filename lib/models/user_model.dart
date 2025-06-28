class User {
  final String name;
  final String email;
  final int age;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'age': age, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      age: json['age'],
      password: json['password'],
    );
  }
}
