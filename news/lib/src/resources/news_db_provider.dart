import 'package:flutter/rendering.dart';
import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDatabaseProvider implements Source, Cache {
  late Database database;

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'items.db');

    database = await openDatabase(path,
        version: 1,
        onCreate: (newDb, version) => {
              database.execute("""
CREATE TABLE items
(
  id INTEGER PRIMARY KEY,
  type text,
  by text,
  time integer,
  text text,
  parent integer,
  kids blob,
  dead integer,
  deleted integer,
  url text,
  score integer, 
  title text,
  descendants interger
)
""")
            });
  }

  Future<ItemModel?> fetchItem(int id) async {
    final maps = await database.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return database.insert("items", item.toMap());
  }

  @override
  Future<List<int>> fetchTopIds() {
    throw UnimplementedError();
  }
}
