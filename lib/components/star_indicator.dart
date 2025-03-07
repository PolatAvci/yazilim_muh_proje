import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/comment_items.dart';

class StarIndicator extends StatelessWidget {
  final int productId;

  StarIndicator({required this.productId});

  double getAverageRating(int productId) {
    List<int> ratings =
        CommentItems.items
            .where((item) => item.containsKey(productId))
            .map((item) => item[productId]!.star)
            .toList();

    if (ratings.isEmpty) return 0.0;
    int sum = 0;
    for (int i in ratings) {
      sum += i;
    }
    return sum / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = getAverageRating(productId);
    double progress = averageRating / 5.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
              ),
            ),
            Text(
              averageRating.toStringAsFixed(1),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
