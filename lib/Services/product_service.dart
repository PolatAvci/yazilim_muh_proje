import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Map<String, dynamic>>?> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:7212/api/Product'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return List<Map<String, dynamic>>.from(data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<bool> getIsFav(int userId, int productId) async {
    final response = await http.get(
      Uri.parse('https://localhost:7212/api/UserFavItem/$userId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> favItems = json.decode(response.body);
      for (var item in favItems) {
        if (item['productId'] == productId) {
          return true;
        }
      }
      return false;
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  static Future<http.Response> addFav(int userId, int productId) async {
    final response = await http.post(
      Uri.parse('https://localhost:7212/api/UserFavItem'),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode({'userId': userId, 'productId': productId}),
    );
    return response;
  }

  static Future<http.Response> removeFav(int userId, int productId) async {
    final response = await http.delete(
      Uri.parse('https://localhost:7212/api/UserFavItem/$userId/$productId'),
    );
    return response;
  }

  static Future<List<dynamic>?> getAllFav(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:7212/api/UserFavItem/$userId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        return data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
