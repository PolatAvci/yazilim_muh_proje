import 'dart:convert';

import 'package:http/http.dart' as http;

class CommentService {
  static Future<http.Response> addComment(int star, String text) async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/Comment"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode({
        "date": DateTime.now().toIso8601String(), //Standart tarih formatı
        "star": star,
        "text": text,
      }),
    );

    return response;
  }
}
