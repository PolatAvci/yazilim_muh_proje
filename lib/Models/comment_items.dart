import 'package:yazilim_muh_proje/Models/comment.dart';

class CommentItems {
  static List<Map<int, Comment>> items = [
    {1: Comment("Çok güzel.", 5, DateTime(2025, 1, 1))},
    {
      1: Comment(
        "Kızıma hediye olarak aldım. Çok beğendi.",
        5,
        DateTime(2025, 1, 1),
      ),
    },
    {2: Comment("Kötü", 1, DateTime(2025, 1, 1))},
    {4: Comment("Farklı rengi yok mu?", 4, DateTime(2025, 1, 1))},
  ];
}
