import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yazilim_muh_proje/Models/order.dart';

class OrderService {
  static Future<List<Order>?> fetchOrders(int userId) async {
    final response = await http.get(
      Uri.parse('https://localhost:7212/api/UserProduct/$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      // Hata durumunda bir işlem yapılabilir
      return null;
    }
  }
}
