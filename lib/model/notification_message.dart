import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// database table and column names
final String tableMessages = 'messages';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnBody = 'body';

class NotificationMessage {
  final int id;
  final String title;
  final String body;

  NotificationMessage({
    @required this.id,
    @required this.title,
    @required this.body,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }

  // convenience constructor to create a Word object
  factory NotificationMessage.fromMap(Map<String, dynamic> map) {
    return NotificationMessage(
      id: map[columnId],
      title: map[columnTitle],
      body: map[columnBody],
    );
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnTitle: title, columnBody: body};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableMessages (
                $columnId INTEGER PRIMARY KEY,
                $columnTitle TEXT,
                $columnBody TEXT
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(NotificationMessage message) async {
    Database db = await database;
    int id = await db.insert(tableMessages, message.toMap());
    return id;
  }

  Future<NotificationMessage> queryMessage(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableMessages,
        columns: [columnId, columnTitle, columnBody],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return NotificationMessage.fromMap(maps.first);
    }
    return null;
  }

  // TODO: queryAllMessages()
  Future<List<NotificationMessage>> queryAllMessages() async {
    Database db = await database;
    List<Map> maps = await db.query(tableMessages);

    List<NotificationMessage> messages = [];
    if (maps.length > 0) {
      // List<Message> messages = [];
      for (var m in maps) {
        messages.add(NotificationMessage.fromMap(m));
      }
      return messages;
    }
    return null;
  }

  // TODO: delete(int id)
  Future<int> delete(int id) async {
    Database db = await database;
    return await db
        .delete(tableMessages, where: '$columnId = ?', whereArgs: [id]);
  }

  // TODO: deleteAll()
  Future<int> deleteAll() async {
    Database db = await database;
    return await db.delete(
      tableMessages,
    );
  }
  // TODO: update(Message message)
}
