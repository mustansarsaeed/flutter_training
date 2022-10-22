import 'dart:convert';

class ItemModel {
  late int id;
  late bool deleted;
  late String type;
  late String by;
  int time = 1203647620;
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
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'] ?? '',
        by = parsedJson['by'] ?? '',
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'] ?? 0,
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'] ?? '',
        score = parsedJson['score'] ?? 0,
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

// created_by text,
//   newsTime integer,
//   content text,
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'created_by': by,
      'newsTime': time,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "content": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "kids": jsonEncode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants
    };
  }
}
