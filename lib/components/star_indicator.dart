import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    try {
      final response = await http.get(
        Uri.parse(
          'https://localhost:7212/api/CommentProduct/${widget.productId}',
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> comments = jsonDecode(response.body);
        if (comments.isNotEmpty) {
          double sum = comments
              .map((comment) => comment["comment"]['star'] as int)
              .fold(0, (prev, star) => prev + star);
          double average = sum / comments.length;

          setState(() {
            _averageRating = average;
          });
        }
      }
    } catch (e) {
      print("Hata: $e");
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
