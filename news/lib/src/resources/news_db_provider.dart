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

  NewsDatabaseProvider() {
    init();
  }

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'items2.db');
    database = await openDatabase(path,
        version: 1,
        onCreate: (newDb, version) => {
              newDb.execute("""
CREATE TABLE items
(
  id INTEGER PRIMARY KEY,
  type text,
  created_by text,
  newsTime integer,
  content text,
  parent integer,
  kids blob,
  dead integer,
  deleted integer,
  url text,
  score integer, 
  title text,
  descendants integer
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
    late Future<int> result;

    try {
      result = database.insert(
        "items",
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex, st) {
      print(ex);
      print(st);
      exit(0);
    }

    return result;
  }

  @override
  Future<List<int>> fetchTopIds() {
    throw UnimplementedError();
  }

  Future<int> clear() {
    return database.delete("items");
  }
}

final newsDatabaseProvider = NewsDatabaseProvider();
