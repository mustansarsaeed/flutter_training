class ItemModel {
  late int id;
  late bool deleted;
  late String type;
  late String by;
  late int time;
  late String text;
  late bool dead;
  late int parent;
  late List<dynamic> kids;
  late String url;
  late int score;
  late String title;
  late int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'],
        type = parsedJson['type'],
        by = parsedJson['by'],
        text = parsedJson['text'],
        dead = parsedJson['dead'],
        parent = parsedJson['parent'],
        kids = parsedJson['kids'],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];
}
