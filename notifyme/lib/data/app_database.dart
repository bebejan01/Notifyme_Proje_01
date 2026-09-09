import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// FAZ 1 database skeleton: UserProfile -> Goal -> Task core.
///
/// This class only owns schema creation. No repository or service reads or
/// writes through it yet (that is FAZ 1 step 2+).
class AppDatabase {
  AppDatabase._internal();

  static final AppDatabase instance = AppDatabase._internal();

  static const int _databaseVersion = 1;
  static const String _databaseName = 'notifyme.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    // All timestamps are stored as ISO 8601 TEXT (DateTime.toIso8601String()),
    // matching the convention already used by Task.toJson/fromJson.

    await db.execute('''
      CREATE TABLE user_profile (
        id TEXT PRIMARY KEY,
        primary_purpose TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE goals (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT,
        priority TEXT NOT NULL,
        deadline TEXT,
        status TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        goal_id TEXT,
        title TEXT NOT NULL,
        description TEXT,
        scheduled_at TEXT,
        planned_duration INTEGER,
        planned_amount REAL,
        unit TEXT,
        actual_amount REAL,
        priority TEXT NOT NULL,
        status TEXT NOT NULL,
        created_at TEXT NOT NULL,
        completed_at TEXT,
        FOREIGN KEY (goal_id) REFERENCES goals (id) ON DELETE SET NULL
      )
    ''');
  }

  // No versions beyond 1 exist yet. This stays empty until a real schema
  // change ships; it is kept only so the upgrade path exists from day one.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}
}
