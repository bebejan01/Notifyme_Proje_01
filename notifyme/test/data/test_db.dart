import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notifyme/data/app_database.dart';

/// Opens a fresh, isolated in-memory database with the FAZ 1 schema for
/// repository unit tests. `sqflite_common_ffi` runs sqlite directly (no
/// platform channel / emulator needed), matching the FAZ 1 audit's test
/// strategy (§12). `singleInstance: false` is required — sqflite caches
/// same-path connections by default, which would make every test share one
/// in-memory database instead of getting its own clean slate.
Future<Database> openTestDatabase() async {
  sqfliteFfiInit();
  final db = await databaseFactoryFfi.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
      version: 1,
      singleInstance: false,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) => AppDatabase.createSchema(db),
    ),
  );
  return db;
}
