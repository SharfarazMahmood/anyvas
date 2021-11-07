import 'dart:convert';

class User {
  String? email;
  String? phone;
  String? username;
  String? firstName;
  String? lastName;
  String? _token;
  String? _credential;

  User({
    this.email,
    this.phone,
    this.username,
    this.firstName,
    this.lastName,
    String? token,
    String? cred,
  }) {
    this._token = token;
    this._credential = cred;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return "no token found";
  }

  String get getCredential {
    if (_credential != null) {
      return _credential.toString();
    }
    return "no credential data availabl";
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      email: jsonData['email'],
      phone: jsonData['phone'],
      username: jsonData['username'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      token: jsonData['token'],
      cred: jsonData['credential'],
    );
  }

  static Map<String, dynamic> toMap(User user) => {
        'email': user.email,
        'phone': user.phone,
        'username': user.username,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'token': user.token,
        'credential': user.getCredential,
      };

  static String encode(User? user) => json.encode(User.toMap(user!));

  static User decode(String userString) {
    var userData = json.decode(userString) as Map<String, dynamic>;
    User user = User.fromJson(userData);
    return user;
  }
}
