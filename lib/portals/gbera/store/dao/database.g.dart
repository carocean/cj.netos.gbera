// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  IUpstreamPersonDAO _upstreamPersonDAOInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Person` (`uid` TEXT, `accountid` TEXT, `accountName` TEXT, `appid` TEXT, `tenantid` TEXT, `avatar` TEXT, PRIMARY KEY (`uid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  IUpstreamPersonDAO get upstreamPersonDAO {
    return _upstreamPersonDAOInstance ??=
        _$IUpstreamPersonDAO(database, changeListener);
  }
}

class _$IUpstreamPersonDAO extends IUpstreamPersonDAO {
  _$IUpstreamPersonDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, dynamic>{
                  'uid': item.uid,
                  'accountid': item.accountid,
                  'accountName': item.accountName,
                  'appid': item.appid,
                  'tenantid': item.tenantid,
                  'avatar': item.avatar
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _personMapper = (Map<String, dynamic> row) => Person(
      row['uid'] as String,
      row['accountid'] as String,
      row['accountName'] as String,
      row['appid'] as String,
      row['tenantid'] as String,
      row['avatar'] as String);

  final InsertionAdapter<Person> _personInsertionAdapter;

  @override
  Future<void> removePerson(String uid) async {
    await _queryAdapter.queryNoReturn('delete FROM Person WHERE uid = ?',
        arguments: <dynamic>[uid]);
  }

  @override
  Future<List<Person>> pagePerson(int currPage, int pageSize) async {
    return _queryAdapter.queryList('SELECT * FROM Person LIMIT ? ?',
        arguments: <dynamic>[currPage, pageSize], mapper: _personMapper);
  }

  @override
  Future<Person> getPerson(String uid) async {
    return _queryAdapter.query('SELECT * FROM Person WHERE uid = ?',
        arguments: <dynamic>[uid], mapper: _personMapper);
  }

  @override
  Future<List<Person>> getAllPerson() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: _personMapper);
  }

  @override
  Future<void> addPerson(Person person) async {
    await _personInsertionAdapter.insert(
        person, sqflite.ConflictAlgorithm.abort);
  }
}
