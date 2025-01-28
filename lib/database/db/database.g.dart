// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $Assignment3DatabaseBuilderContract {
  /// Adds migrations to the builder.
  $Assignment3DatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $Assignment3DatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<Assignment3Database> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAssignment3Database {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $Assignment3DatabaseBuilderContract databaseBuilder(String name) =>
      _$Assignment3DatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $Assignment3DatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$Assignment3DatabaseBuilder(null);
}

class _$Assignment3DatabaseBuilder
    implements $Assignment3DatabaseBuilderContract {
  _$Assignment3DatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $Assignment3DatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $Assignment3DatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<Assignment3Database> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$Assignment3Database();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$Assignment3Database extends Assignment3Database {
  _$Assignment3Database([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UniversityDao? _universityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `University` (`id` INTEGER, `name` TEXT, `webPages` TEXT, `country` TEXT, `domains` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UniversityDao get universityDao {
    return _universityDaoInstance ??= _$UniversityDao(database, changeListener);
  }
}

class _$UniversityDao extends UniversityDao {
  _$UniversityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _universityInsertionAdapter = InsertionAdapter(
            database,
            'University',
            (University item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'webPages': item.webPages,
                  'country': item.country,
                  'domains': item.domains
                }),
        _universityUpdateAdapter = UpdateAdapter(
            database,
            'University',
            ['id'],
            (University item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'webPages': item.webPages,
                  'country': item.country,
                  'domains': item.domains
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<University> _universityInsertionAdapter;

  final UpdateAdapter<University> _universityUpdateAdapter;

  @override
  Future<List<University>> getUniversityList() async {
    return _queryAdapter.queryList('SELECT * FROM University',
        mapper: (Map<String, Object?> row) => University(
            name: row['name'] as String?,
            webPages: row['webPages'] as String?,
            country: row['country'] as String?,
            domains: row['domains'] as String?));
  }

  @override
  Future<University?> deleteUniversity(String id) async {
    return _queryAdapter.query('DELETE FROM University WHERE productId = ?1',
        mapper: (Map<String, Object?> row) => University(
            name: row['name'] as String?,
            webPages: row['webPages'] as String?,
            country: row['country'] as String?,
            domains: row['domains'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> cleanUniversityTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM University');
  }

  @override
  Future<List<int>> insertUniversityList(List<University> universityList) {
    return _universityInsertionAdapter.insertListAndReturnIds(
        universityList, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateUniversity(University university) {
    return _universityUpdateAdapter.updateAndReturnChangedRows(
        university, OnConflictStrategy.abort);
  }
}
