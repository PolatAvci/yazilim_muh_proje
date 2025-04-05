import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yazilim_muh_proje/Models/comment.dart';

class CommentService {
  static Future<http.Response> _addCommentUser(
    int productId,
    int commentId,
  ) async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/Commentproduct"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında gönderildiğini belirt
      },
      body: json.encode({"productId": productId, "commentId": commentId}),
    );
    return response;
  }

  static Future<http.Response> addComment(
    int star,
    String text,
    int productId,
  ) async {
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

    final int commentId = json.decode(response.body)["id"];

    if (response.statusCode == 201) {
      final res = await _addCommentUser(productId, commentId);
      return res;
    } else {
      return await http.delete(
        Uri.parse("https://localhost:7212/api/Comment/$commentId"),
      );
    }
  }

  static Future<List<Comment>> getComments(int productId) async {
    final List<Comment> comments = [];
    final response = await http.get(
      Uri.parse("https://localhost:7212/api/CommentProduct/$productId"),
    );

    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        comments.add(Comment.fromJson(item));
      }
    }
    return comments;
  }
}
