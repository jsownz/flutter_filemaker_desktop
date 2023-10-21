import 'package:flutter_filemaker_desktop/models/db_connection.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteConnector {
  connect() async {
    databaseFactory = databaseFactoryFfi;
    final connectionDatabase = openDatabase(
      join(await getDatabasesPath(), 'connection_database.db'),
      onCreate: (db, version) {
        print('create');
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE connections(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, connection_name TEXT, type INTEGER, database_name TEXT, connection_uri TEXT, app_id TEXT)',
        );
      },
      version: 1,
    );
    return connectionDatabase;
  }

  insert(
    connectionDatabase,
    String table,
    dynamic model,
  ) async {
    final db = await connectionDatabase;

    await db.insert(
      table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
