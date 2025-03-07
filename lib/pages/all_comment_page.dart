import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/comment.dart';
import 'package:yazilim_muh_proje/Models/comment_items.dart';
import 'package:yazilim_muh_proje/components/star_indicator.dart';

class AllCommentPage extends StatelessWidget {
  final int id;
  const AllCommentPage({super.key, required this.id});

  List<Comment> _getComments(id) {
    return CommentItems.items
        .where((map) => map.containsKey(id))
        .map((map) => map[id]!)
        .toList();
  }

  // Method to draw stars for rating
  Widget buildStarRating(int starCount) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(
        Icon(
          i < starCount ? Icons.star : Icons.star_border,
          color: Colors.yellow.shade700,
          size: 18,
        ),
      );
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    List<Comment> comments = _getComments(id);

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
              StarIndicator(productId: id),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  var comment = comments[index];

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
                        comment.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          buildStarRating(
                            comment.star,
                          ), // Call the star rating method
                          SizedBox(width: 4),
                          Text(
                            comment.star.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 14),
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
