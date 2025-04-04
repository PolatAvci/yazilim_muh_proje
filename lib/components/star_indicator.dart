import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/comment.dart';
import 'package:yazilim_muh_proje/Services/comment_service.dart';

class StarIndicator extends StatefulWidget {
  final int productId;

  const StarIndicator({super.key, required this.productId});

  @override
  _StarIndicatorState createState() => _StarIndicatorState();
}

class _StarIndicatorState extends State<StarIndicator> {
  double _averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchAverageRating();
  }

  @override
  void didUpdateWidget(covariant StarIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {});
  }

  Future<void> fetchAverageRating() async {
    final List<Comment> comments = await CommentService.getComments(
      widget.productId,
    );

    if (comments.isNotEmpty) {
      double sum = comments
          .map((comment) => comment.star)
          .fold(0, (prev, star) => prev + star);
      double average = sum / comments.length;

      setState(() {
        _averageRating = average;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = _averageRating / 5.0;

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
              _averageRating.toStringAsFixed(1),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
