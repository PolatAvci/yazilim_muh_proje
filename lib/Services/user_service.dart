import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yazilim_muh_proje/Models/user.dart';

class UserService {
  static User? _user;
  static get user => _user;

  static void logout() {
    _user = null;
  }

  static Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/User/Login"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      _user = User.fromJson(jsonDecode(response.body));
    }
    return _user;
  }

  static Future<http.Response> register(User user) async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/User"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode(user.toJson()),
    );
    return response;
  }
}
