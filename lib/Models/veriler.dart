import 'package:yazilim_muh_proje/Models/user.dart';

class Veriler {
  static List<User> kullanicilar = [
    User(email: "polat@gmail.com", password: "123456"),
    User(email: "kerem@gmail.com", password: "123456"),
    User(email: "berk@gmail.com", password: "123456"),
    User(email: "beyza@gmail.com", password: "123456"),
    User(email: "iremsu@gmail.com", password: "123456"),
  ];

  static void addUser(User newUser) {
    kullanicilar.add(newUser);
  }
}
