import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yazilim_muh_proje/Models/address.dart';

class AddressService {
  static Future<List<Address>> getAddresses(int userId) async {
    try {
      final response = await http.get(
        Uri.parse("https://localhost:7212/api/AddressUser/$userId"),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => Address.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<http.Response> _addAdressUser(int userId, int addresId) async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/AddressUser"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode({"userId": userId, "addressId": addresId}),
    );
    return response;
  }

  static Future<http.Response> addAddress(
    int userId,
    String info,
    String city,
  ) async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/Address"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode({"addressInfo": info, "city": city}),
    );
    if (response.statusCode != 201) {
      return response;
    }
    final int addresId = json.decode(response.body)["id"];

    final res = await _addAdressUser(userId, addresId);
    if (res.statusCode != 201) {
      await http.delete(
        Uri.parse("https://localhost:7212/api/Address/$addresId"),
      );
      return res;
    }

    return response;
  }

  static Future<http.Response> removeAddress(int userId, int addressId) async {
    final response = await http.delete(
      Uri.parse("https://localhost:7212/api/Address/$addressId"),
    );
    return response;
  }
}
