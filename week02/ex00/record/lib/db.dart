import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:record/database/storageClass.dart';

final String tableName = 'text';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(
        await getDatabasesPath(),
        'contents.db',
      ),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE text(idx INTEGER PRIMARY KEY, title TEXT, content TEXT, createTime TEXT, editTime TEXT)");
      },
      version: 1,
    );
    return _db;
  }
}

Future<void> insertContent(Storage storage) async {
  final db = await database;
  await db.insert(
    tableName,
    storage.toMap(),
    ConflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Storage>> storages() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('storages');
}
