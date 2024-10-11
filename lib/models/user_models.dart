class User {
  final String id;
  final String userName;
  final String email;
  final String password;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}
