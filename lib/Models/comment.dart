class Comment {
  int id;
  DateTime date;
  String text;
  int star;

  Comment({
    required this.id,
    required this.text,
    required this.star,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['productId'],
      date: DateTime.parse(json['comment']["date"]),
      star: json["comment"]['star'],
      text: json["comment"]['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'date': date, 'text': text, 'star': star};
  }
}
