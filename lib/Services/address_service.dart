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
}
