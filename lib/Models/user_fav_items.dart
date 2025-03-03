class UserFavItems {
  //{userId : fav_productId}
  static List<Map<int, int>> items = [
    {1: 1},
    {2: 1},
    {1: 4},
  ];

  static List<int> getAllValuesByUserId(int userId) {
    List<int> values = [];

    for (var map in items) {
      if (map.containsKey(userId)) {
        values.add(
          map[userId]!,
        ); // Null olamayacağını bildiğimiz için "!" ekledik
      }
    }

    return values;
  }

  static void removeFavorite(int userId, int productId) {
    items.removeWhere(
      (map) => map.containsKey(userId) && map[userId] == productId,
    );
  }
}
