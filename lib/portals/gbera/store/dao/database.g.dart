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

  IDownstreamPersonDAO _downstreamPersonDAOInstance;

  IMicroSiteDAO _microSiteDAOInstance;

  IMicroAppDAO _microAppDAOInstance;

  IExternalChannelDAO _externalChannelDAOInstance;

  IInsiteMessageDAO _insiteMessageDAOInstance;

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
            'CREATE TABLE IF NOT EXISTS `UpstreamPerson` (`id` TEXT, `uid` TEXT, `accountid` TEXT, `accountName` TEXT, `appid` TEXT, `tenantid` TEXT, `avatar` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DownstreamPerson` (`id` TEXT, `uid` TEXT, `accountid` TEXT, `accountName` TEXT, `appid` TEXT, `tenantid` TEXT, `avatar` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MicroSite` (`id` TEXT, `name` TEXT, `leading` TEXT, `desc` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MicroApp` (`id` TEXT, `site` TEXT, `leading` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ExternalChannel` (`id` TEXT, `name` TEXT, `owner` TEXT, `isPublic` INTEGER, `leading` TEXT, `site` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `InsiteMessage` (`id` TEXT, `upstreamPerson` TEXT, `upstreamChannel` TEXT, `sourceSite` TEXT, `sourceApp` TEXT, `sourceChannel` TEXT, `creator` TEXT, `ctime` INTEGER, `digests` TEXT, `wy` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelMessage` (`id` TEXT, `upstreamPerson` TEXT, `upstreamChannel` TEXT, `sourceSite` TEXT, `sourceApp` TEXT, `sourceChannel` TEXT, `creator` TEXT, `ctime` INTEGER, `text` TEXT, `wy` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Comment` (`id` TEXT, `person` TEXT, `uid` TEXT, `avatar` TEXT, `msgid` TEXT, `text` TEXT, `ctime` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Media` (`id` TEXT, `type` TEXT, `src` TEXT, `leading` TEXT, `msgid` TEXT, `text` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MyChannel` (`id` TEXT, `name` TEXT, `owner` TEXT, `isPublic` INTEGER, `leading` TEXT, `site` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelInput` (`id` TEXT, `fromChannel` TEXT, `fromPerson` TEXT, `toChannel` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelOutput` (`id` TEXT, `geoSelector` TEXT, `wechatPenYouSelector` TEXT, `wechatHaoYouSelector` TEXT, `contractSelector` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelOutputPerson` (`id` TEXT, `fromChannel` TEXT, `toPerson` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  IUpstreamPersonDAO get upstreamPersonDAO {
    return _upstreamPersonDAOInstance ??=
        _$IUpstreamPersonDAO(database, changeListener);
  }

  @override
  IDownstreamPersonDAO get downstreamPersonDAO {
    return _downstreamPersonDAOInstance ??=
        _$IDownstreamPersonDAO(database, changeListener);
  }

  @override
  IMicroSiteDAO get microSiteDAO {
    return _microSiteDAOInstance ??= _$IMicroSiteDAO(database, changeListener);
  }

  @override
  IMicroAppDAO get microAppDAO {
    return _microAppDAOInstance ??= _$IMicroAppDAO(database, changeListener);
  }

  @override
  IExternalChannelDAO get externalChannelDAO {
    return _externalChannelDAOInstance ??=
        _$IExternalChannelDAO(database, changeListener);
  }

  @override
  IInsiteMessageDAO get insiteMessageDAO {
    return _insiteMessageDAOInstance ??=
        _$IInsiteMessageDAO(database, changeListener);
  }
}

class _$IUpstreamPersonDAO extends IUpstreamPersonDAO {
  _$IUpstreamPersonDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _upstreamPersonInsertionAdapter = InsertionAdapter(
            database,
            'UpstreamPerson',
            (UpstreamPerson item) => <String, dynamic>{
                  'id': item.id,
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

  static final _upstreamPersonMapper = (Map<String, dynamic> row) =>
      UpstreamPerson(
          row['id'] as String,
          row['uid'] as String,
          row['accountid'] as String,
          row['accountName'] as String,
          row['appid'] as String,
          row['tenantid'] as String,
          row['avatar'] as String);

  final InsertionAdapter<UpstreamPerson> _upstreamPersonInsertionAdapter;

  @override
  Future<void> removePerson(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM UpstreamPerson WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM UpstreamPerson');
  }

  @override
  Future<List<UpstreamPerson>> pagePerson(int currPage, int pageSize) async {
    return _queryAdapter.queryList(
        'SELECT * FROM UpstreamPerson LIMIT ? OFFSET ?',
        arguments: <dynamic>[currPage, pageSize],
        mapper: _upstreamPersonMapper);
  }

  @override
  Future<UpstreamPerson> getPerson(String id) async {
    return _queryAdapter.query('SELECT * FROM UpstreamPerson WHERE id = ?',
        arguments: <dynamic>[id], mapper: _upstreamPersonMapper);
  }

  @override
  Future<List<UpstreamPerson>> getAllPerson() async {
    return _queryAdapter.queryList('SELECT * FROM UpstreamPerson',
        mapper: _upstreamPersonMapper);
  }

  @override
  Future<void> addPerson(UpstreamPerson person) async {
    await _upstreamPersonInsertionAdapter.insert(
        person, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IDownstreamPersonDAO extends IDownstreamPersonDAO {
  _$IDownstreamPersonDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _downstreamPersonInsertionAdapter = InsertionAdapter(
            database,
            'DownstreamPerson',
            (DownstreamPerson item) => <String, dynamic>{
                  'id': item.id,
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

  static final _downstreamPersonMapper = (Map<String, dynamic> row) =>
      DownstreamPerson(
          row['id'] as String,
          row['uid'] as String,
          row['accountid'] as String,
          row['accountName'] as String,
          row['appid'] as String,
          row['tenantid'] as String,
          row['avatar'] as String);

  final InsertionAdapter<DownstreamPerson> _downstreamPersonInsertionAdapter;

  @override
  Future<void> removePerson(String id) async {
    await _queryAdapter.queryNoReturn(
        'delete FROM DownstreamPerson WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM DownstreamPerson');
  }

  @override
  Future<List<DownstreamPerson>> pagePerson(int currPage, int pageSize) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DownstreamPerson LIMIT ? OFFSET ?',
        arguments: <dynamic>[currPage, pageSize],
        mapper: _downstreamPersonMapper);
  }

  @override
  Future<DownstreamPerson> getPerson(String id) async {
    return _queryAdapter.query('SELECT * FROM DownstreamPerson WHERE id = ?',
        arguments: <dynamic>[id], mapper: _downstreamPersonMapper);
  }

  @override
  Future<List<DownstreamPerson>> getAllPerson() async {
    return _queryAdapter.queryList('SELECT * FROM DownstreamPerson',
        mapper: _downstreamPersonMapper);
  }

  @override
  Future<void> addPerson(DownstreamPerson person) async {
    await _downstreamPersonInsertionAdapter.insert(
        person, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IMicroSiteDAO extends IMicroSiteDAO {
  _$IMicroSiteDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _microSiteInsertionAdapter = InsertionAdapter(
            database,
            'MicroSite',
            (MicroSite item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'leading': item.leading,
                  'desc': item.desc
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _microSiteMapper = (Map<String, dynamic> row) => MicroSite(
      row['id'] as String,
      row['name'] as String,
      row['leading'] as String,
      row['desc'] as String);

  final InsertionAdapter<MicroSite> _microSiteInsertionAdapter;

  @override
  Future<void> removeSite(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM MicroSite WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<MicroSite>> pageSite(int currPage, int pageSize) async {
    return _queryAdapter.queryList('SELECT * FROM MicroSite LIMIT ? OFFSET ?',
        arguments: <dynamic>[currPage, pageSize], mapper: _microSiteMapper);
  }

  @override
  Future<MicroSite> getSite(String id) async {
    return _queryAdapter.query('SELECT * FROM MicroSite WHERE id = ?',
        arguments: <dynamic>[id], mapper: _microSiteMapper);
  }

  @override
  Future<List<MicroSite>> getAllSite() async {
    return _queryAdapter.queryList('SELECT * FROM MicroSite',
        mapper: _microSiteMapper);
  }

  @override
  Future<void> addSite(MicroSite site) async {
    await _microSiteInsertionAdapter.insert(
        site, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IMicroAppDAO extends IMicroAppDAO {
  _$IMicroAppDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _microAppInsertionAdapter = InsertionAdapter(
            database,
            'MicroApp',
            (MicroApp item) => <String, dynamic>{
                  'id': item.id,
                  'site': item.site,
                  'leading': item.leading
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _microAppMapper = (Map<String, dynamic> row) => MicroApp(
      row['id'] as String, row['site'] as String, row['leading'] as String);

  final InsertionAdapter<MicroApp> _microAppInsertionAdapter;

  @override
  Future<void> removeApp(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM MicroApp WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<MicroApp>> pageApp(int currPage, int pageSize) async {
    return _queryAdapter.queryList('SELECT * FROM MicroApp LIMIT ? OFFSET ?',
        arguments: <dynamic>[currPage, pageSize], mapper: _microAppMapper);
  }

  @override
  Future<MicroApp> getApp(String id) async {
    return _queryAdapter.query('SELECT * FROM MicroApp WHERE id = ?',
        arguments: <dynamic>[id], mapper: _microAppMapper);
  }

  @override
  Future<List<MicroApp>> getAllApp() async {
    return _queryAdapter.queryList('SELECT * FROM MicroApp',
        mapper: _microAppMapper);
  }

  @override
  Future<void> addApp(MicroApp site) async {
    await _microAppInsertionAdapter.insert(
        site, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IExternalChannelDAO extends IExternalChannelDAO {
  _$IExternalChannelDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _externalChannelInsertionAdapter = InsertionAdapter(
            database,
            'ExternalChannel',
            (ExternalChannel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'owner': item.owner,
                  'isPublic': item.isPublic ? 1 : 0,
                  'leading': item.leading,
                  'site': item.site
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _externalChannelMapper = (Map<String, dynamic> row) =>
      ExternalChannel(
          row['id'] as String,
          row['name'] as String,
          row['owner'] as String,
          (row['isPublic'] as int) != 0,
          row['leading'] as String,
          row['site'] as String);

  final InsertionAdapter<ExternalChannel> _externalChannelInsertionAdapter;

  @override
  Future<void> removeChannel(String channelid) async {
    await _queryAdapter.queryNoReturn(
        'delete FROM ExternalChannel WHERE id = ?',
        arguments: <dynamic>[channelid]);
  }

  @override
  Future<List<ExternalChannel>> pageChannel(int currPage, int pageSize) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ExternalChannel LIMIT ? OFFSET ?',
        arguments: <dynamic>[currPage, pageSize],
        mapper: _externalChannelMapper);
  }

  @override
  Future<ExternalChannel> getChannel(String channelid) async {
    return _queryAdapter.query('SELECT * FROM ExternalChannel WHERE id = ?',
        arguments: <dynamic>[channelid], mapper: _externalChannelMapper);
  }

  @override
  Future<List<ExternalChannel>> getAllChannel() async {
    return _queryAdapter.queryList('SELECT * FROM ExternalChannel',
        mapper: _externalChannelMapper);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM ExternalChannel');
  }

  @override
  Future<void> emptyOfPerson(String personid) async {
    await _queryAdapter.queryNoReturn(
        'delete FROM ExternalChannel WHERE owner = ?',
        arguments: <dynamic>[personid]);
  }

  @override
  Future<List<ExternalChannel>> getChannelsOfPerson(String personid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ExternalChannel WHERE owner = ?',
        arguments: <dynamic>[personid],
        mapper: _externalChannelMapper);
  }

  @override
  Future<void> addChannel(ExternalChannel channel) async {
    await _externalChannelInsertionAdapter.insert(
        channel, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IInsiteMessageDAO extends IInsiteMessageDAO {
  _$IInsiteMessageDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _insiteMessageInsertionAdapter = InsertionAdapter(
            database,
            'InsiteMessage',
            (InsiteMessage item) => <String, dynamic>{
                  'id': item.id,
                  'upstreamPerson': item.upstreamPerson,
                  'upstreamChannel': item.upstreamChannel,
                  'sourceSite': item.sourceSite,
                  'sourceApp': item.sourceApp,
                  'sourceChannel': item.sourceChannel,
                  'creator': item.creator,
                  'ctime': item.ctime,
                  'digests': item.digests,
                  'wy': item.wy
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _insiteMessageMapper = (Map<String, dynamic> row) =>
      InsiteMessage(
          row['id'] as String,
          row['upstreamPerson'] as String,
          row['upstreamChannel'] as String,
          row['sourceSite'] as String,
          row['sourceApp'] as String,
          row['sourceChannel'] as String,
          row['creator'] as String,
          row['ctime'] as int,
          row['digests'] as String,
          row['wy'] as double);

  final InsertionAdapter<InsiteMessage> _insiteMessageInsertionAdapter;

  @override
  Future<void> removeMessage(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM InsiteMessage WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<InsiteMessage>> pageMessage(int currPage, int pageSize) async {
    return _queryAdapter.queryList(
        'SELECT * FROM InsiteMessage LIMIT ? OFFSET ?',
        arguments: <dynamic>[currPage, pageSize],
        mapper: _insiteMessageMapper);
  }

  @override
  Future<InsiteMessage> getMessage(String id) async {
    return _queryAdapter.query('SELECT * FROM InsiteMessage WHERE id = ?',
        arguments: <dynamic>[id], mapper: _insiteMessageMapper);
  }

  @override
  Future<List<InsiteMessage>> getAllMessage() async {
    return _queryAdapter.queryList(
        'SELECT * FROM InsiteMessage LIMIT 1 OFFSET 0',
        mapper: _insiteMessageMapper);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM InsiteMessage');
  }

  @override
  Future<void> addMessage(InsiteMessage message) async {
    await _insiteMessageInsertionAdapter.insert(
        message, sqflite.ConflictAlgorithm.abort);
  }
}
