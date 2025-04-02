import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yazilim_muh_proje/components/star_indicator.dart';

class AllCommentPage extends StatefulWidget {
  final int id;

  const AllCommentPage({super.key, required this.id});

  @override
  _AllCommentPageState createState() => _AllCommentPageState();
}

class _AllCommentPageState extends State<AllCommentPage> {
  List<Map<String, dynamic>> _comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:7212/api/CommentProduct/${widget.id}'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _comments = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  // Yıldızları göstermek için widget
  Widget buildStarRating(int starCount) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < starCount ? Icons.star : Icons.star_border,
          color: Colors.yellow.shade700,
          size: 18,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "Tüm Yorumlar",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Ortalama",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              StarIndicator(productId: widget.id),
              SizedBox(height: 10),
              _comments.isEmpty
                  ? Center(child: Text("Henüz yorum yok."))
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      var comment = _comments[index];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4.0,
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: Icon(
                            Icons.comment,
                            color: Colors.blue.shade600,
                            size: 30,
                          ),
                          title: Text(
                            comment['text'] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              buildStarRating(comment['star'] ?? 0),
                              SizedBox(width: 4),
                              Text(
                                "${comment['star'] ?? 0}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
