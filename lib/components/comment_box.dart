import 'package:flutter/material.dart';

class CommentBox extends StatefulWidget {
  final String text;
  final int star;
  final DateTime date;
  const CommentBox({
    super.key,
    required this.text,
    required this.star,
    required this.date,
  });

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  String _dateTimeToString(DateTime date) {
    List<String> temp = widget.date.toString().split(" ")[0].split("-");
    return "${temp[2]}.${temp[1]}.${temp[0]}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey.shade100,
      width: 300,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children:
                  List.generate(5, (index) {
                    return widget.star > index
                        ? Icon(Icons.star, color: Colors.blue.shade400)
                        : Icon(Icons.star_border, color: Colors.blue.shade400);
                  }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Flexible(child: Text(_dateTimeToString(widget.date)))],
            ),
          ],
        ),
      ),
    );
  }
}
