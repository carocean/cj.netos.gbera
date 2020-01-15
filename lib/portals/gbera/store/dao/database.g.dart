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

  IPersonDAO _upstreamPersonDAOInstance;

  IMicroSiteDAO _microSiteDAOInstance;

  IMicroAppDAO _microAppDAOInstance;

  IChannelDAO _channelDAOInstance;

  IInsiteMessageDAO _insiteMessageDAOInstance;

  IChannelMessageDAO _channelMessageDAOInstance;

  IChannelMediaDAO _channelMediaDAOInstance;

  IChannelLikePersonDAO _channelLikeDAOInstance;

  IChannelCommentDAO _channelCommentDAOInstance;

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
            'CREATE TABLE IF NOT EXISTS `Person` (`id` TEXT, `uid` TEXT, `accountid` TEXT, `accountName` TEXT, `appid` TEXT, `tenantid` TEXT, `avatar` TEXT, `rights` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MicroSite` (`id` TEXT, `name` TEXT, `leading` TEXT, `desc` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MicroApp` (`id` TEXT, `site` TEXT, `leading` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Channel` (`id` TEXT, `name` TEXT, `owner` TEXT, `loopType` TEXT, `leading` TEXT, `site` TEXT, `tips` TEXT, `ctime` INTEGER, `utime` INTEGER, `unreadMsgCount` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `InsiteMessage` (`id` TEXT, `upstreamPerson` TEXT, `upstreamChannel` TEXT, `sourceSite` TEXT, `sourceApp` TEXT, `sourceChannel` TEXT, `creator` TEXT, `ctime` INTEGER, `digests` TEXT, `wy` REAL, `location` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelMessage` (`id` TEXT, `upstreamPerson` TEXT, `upstreamChannel` TEXT, `sourceSite` TEXT, `sourceApp` TEXT, `sourceChannel` TEXT, `creator` TEXT, `ctime` INTEGER, `text` TEXT, `wy` REAL, `location` TEXT, `onChannel` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelComment` (`id` TEXT, `person` TEXT, `uid` TEXT, `avatar` TEXT, `msgid` TEXT, `text` TEXT, `ctime` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LikePerson` (`id` TEXT, `person` TEXT, `uid` TEXT, `avatar` TEXT, `msgid` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Media` (`id` TEXT, `type` TEXT, `src` TEXT, `leading` TEXT, `msgid` TEXT, `text` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelInput` (`id` TEXT, `upstreamPerson` TEXT, `toChannel` TEXT, `rights` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelOutput` (`id` TEXT, `geoSelector` TEXT, `wechatPenYouSelector` TEXT, `wechatHaoYouSelector` TEXT, `contractSelector` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChannelOutputPerson` (`id` TEXT, `fromChannel` TEXT, `toPerson` TEXT, `rights` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  IPersonDAO get upstreamPersonDAO {
    return _upstreamPersonDAOInstance ??=
        _$IPersonDAO(database, changeListener);
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
  IChannelDAO get channelDAO {
    return _channelDAOInstance ??= _$IChannelDAO(database, changeListener);
  }

  @override
  IInsiteMessageDAO get insiteMessageDAO {
    return _insiteMessageDAOInstance ??=
        _$IInsiteMessageDAO(database, changeListener);
  }

  @override
  IChannelMessageDAO get channelMessageDAO {
    return _channelMessageDAOInstance ??=
        _$IChannelMessageDAO(database, changeListener);
  }

  @override
  IChannelMediaDAO get channelMediaDAO {
    return _channelMediaDAOInstance ??=
        _$IChannelMediaDAO(database, changeListener);
  }

  @override
  IChannelLikePersonDAO get channelLikeDAO {
    return _channelLikeDAOInstance ??=
        _$IChannelLikePersonDAO(database, changeListener);
  }

  @override
  IChannelCommentDAO get channelCommentDAO {
    return _channelCommentDAOInstance ??=
        _$IChannelCommentDAO(database, changeListener);
  }
}

class _$IPersonDAO extends IPersonDAO {
  _$IPersonDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'accountid': item.accountid,
                  'accountName': item.accountName,
                  'appid': item.appid,
                  'tenantid': item.tenantid,
                  'avatar': item.avatar,
                  'rights': item.rights
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _personMapper = (Map<String, dynamic> row) => Person(
      row['id'] as String,
      row['uid'] as String,
      row['accountid'] as String,
      row['accountName'] as String,
      row['appid'] as String,
      row['tenantid'] as String,
      row['avatar'] as String,
      row['rights'] as String);

  final InsertionAdapter<Person> _personInsertionAdapter;

  @override
  Future<void> removePerson(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM Person WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM Person');
  }

  @override
  Future<List<Person>> pagePerson(int pageSize, int currPage) async {
    return _queryAdapter.queryList('SELECT * FROM Person LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage], mapper: _personMapper);
  }

  @override
  Future<Person> getPerson(String id) async {
    return _queryAdapter.query('SELECT * FROM Person WHERE id = ?',
        arguments: <dynamic>[id], mapper: _personMapper);
  }

  @override
  Future<List<Person>> getAllPerson() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: _personMapper);
  }

  @override
  Future<List<Person>> countPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: _personMapper);
  }

  @override
  Future<void> addPerson(Person person) async {
    await _personInsertionAdapter.insert(
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
  Future<List<MicroSite>> pageSite(int pageSize, int currPage) async {
    return _queryAdapter.queryList('SELECT * FROM MicroSite LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage], mapper: _microSiteMapper);
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
  Future<List<MicroApp>> pageApp(int pageSize, int currPage) async {
    return _queryAdapter.queryList('SELECT * FROM MicroApp LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage], mapper: _microAppMapper);
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

class _$IChannelDAO extends IChannelDAO {
  _$IChannelDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _channelInsertionAdapter = InsertionAdapter(
            database,
            'Channel',
            (Channel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'owner': item.owner,
                  'loopType': item.loopType,
                  'leading': item.leading,
                  'site': item.site,
                  'tips': item.tips,
                  'ctime': item.ctime,
                  'utime': item.utime,
                  'unreadMsgCount': item.unreadMsgCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _channelMapper = (Map<String, dynamic> row) => Channel(
      row['id'] as String,
      row['name'] as String,
      row['owner'] as String,
      row['loopType'] as String,
      row['leading'] as String,
      row['site'] as String,
      row['tips'] as String,
      row['ctime'] as int,
      row['utime'] as int,
      row['unreadMsgCount'] as int);

  final InsertionAdapter<Channel> _channelInsertionAdapter;

  @override
  Future<void> removeChannel(String channelid) async {
    await _queryAdapter.queryNoReturn('delete FROM Channel WHERE id = ?',
        arguments: <dynamic>[channelid]);
  }

  @override
  Future<List<Channel>> pageChannel(int pageSize, int currPage) async {
    return _queryAdapter.queryList('SELECT * FROM Channel LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage], mapper: _channelMapper);
  }

  @override
  Future<Channel> getChannel(String channelid) async {
    return _queryAdapter.query('SELECT * FROM Channel WHERE id = ?',
        arguments: <dynamic>[channelid], mapper: _channelMapper);
  }

  @override
  Future<List<Channel>> getAllChannel() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Channel ORDER BY utime DESC,ctime DESC',
        mapper: _channelMapper);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM Channel');
  }

  @override
  Future<void> emptyOfPerson(String personid) async {
    await _queryAdapter.queryNoReturn('delete FROM Channel WHERE owner = ?',
        arguments: <dynamic>[personid]);
  }

  @override
  Future<List<Channel>> getChannelsOfPerson(String personid) async {
    return _queryAdapter.queryList('SELECT * FROM Channel WHERE owner = ?',
        arguments: <dynamic>[personid], mapper: _channelMapper);
  }

  @override
  Future<Channel> getChannelByName(String channelName, String owner) async {
    return _queryAdapter.query(
        'SELECT * FROM Channel WHERE name = ? AND owner = ?',
        arguments: <dynamic>[channelName, owner],
        mapper: _channelMapper);
  }

  @override
  Future<void> updateLeading(String path, String channelid) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Channel SET leading = ? WHERE id = ?',
        arguments: <dynamic>[path, channelid]);
  }

  @override
  Future<void> addChannel(Channel channel) async {
    await _channelInsertionAdapter.insert(
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
                  'wy': item.wy,
                  'location': item.location
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
          row['wy'] as double,
          row['location'] as String);

  final InsertionAdapter<InsiteMessage> _insiteMessageInsertionAdapter;

  @override
  Future<void> removeMessage(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM InsiteMessage WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM InsiteMessage LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage],
        mapper: _insiteMessageMapper);
  }

  @override
  Future<List<InsiteMessage>> pageMessageByChannelLoopType(
      String loopType, int limit, int offset) async {
    return _queryAdapter.queryList(
        'SELECT msg.* FROM InsiteMessage msg,Channel ch WHERE msg.upstreamChannel=ch.id AND ch.loopType=? LIMIT ? OFFSET ?',
        arguments: <dynamic>[loopType, limit, offset],
        mapper: _insiteMessageMapper);
  }

  @override
  Future<InsiteMessage> getMessage(String id) async {
    return _queryAdapter.query('SELECT * FROM InsiteMessage WHERE id = ?',
        arguments: <dynamic>[id], mapper: _insiteMessageMapper);
  }

  @override
  Future<List<InsiteMessage>> getAllMessage() async {
    return _queryAdapter.queryList('SELECT * FROM InsiteMessage',
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

class _$IChannelMessageDAO extends IChannelMessageDAO {
  _$IChannelMessageDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _channelMessageInsertionAdapter = InsertionAdapter(
            database,
            'ChannelMessage',
            (ChannelMessage item) => <String, dynamic>{
                  'id': item.id,
                  'upstreamPerson': item.upstreamPerson,
                  'upstreamChannel': item.upstreamChannel,
                  'sourceSite': item.sourceSite,
                  'sourceApp': item.sourceApp,
                  'sourceChannel': item.sourceChannel,
                  'creator': item.creator,
                  'ctime': item.ctime,
                  'text': item.text,
                  'wy': item.wy,
                  'location': item.location,
                  'onChannel': item.onChannel
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _channelMessageMapper = (Map<String, dynamic> row) =>
      ChannelMessage(
          row['id'] as String,
          row['upstreamPerson'] as String,
          row['upstreamChannel'] as String,
          row['sourceSite'] as String,
          row['sourceApp'] as String,
          row['sourceChannel'] as String,
          row['creator'] as String,
          row['ctime'] as int,
          row['text'] as String,
          row['wy'] as double,
          row['location'] as String,
          row['onChannel'] as String);

  final InsertionAdapter<ChannelMessage> _channelMessageInsertionAdapter;

  @override
  Future<void> removeMessage(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM ChannelMessage WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<ChannelMessage>> pageMessage(
      String onChannel, int pageSize, int currPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ChannelMessage WHERE onChannel = ? ORDER BY ctime DESC LIMIT ? OFFSET ?',
        arguments: <dynamic>[onChannel, pageSize, currPage],
        mapper: _channelMessageMapper);
  }

  @override
  Future<List<ChannelMessage>> pageMessageByChannelLoopType(
      String loopType, int limit, int offset) async {
    return _queryAdapter.queryList(
        'SELECT msg.* FROM ChannelMessage msg,Channel ch WHERE msg.upstreamChannel=ch.id AND ch.loopType=? LIMIT ? OFFSET ?',
        arguments: <dynamic>[loopType, limit, offset],
        mapper: _channelMessageMapper);
  }

  @override
  Future<ChannelMessage> getMessage(String id) async {
    return _queryAdapter.query('SELECT * FROM ChannelMessage WHERE id = ?',
        arguments: <dynamic>[id], mapper: _channelMessageMapper);
  }

  @override
  Future<List<ChannelMessage>> getAllMessage() async {
    return _queryAdapter.queryList('SELECT * FROM ChannelMessage',
        mapper: _channelMessageMapper);
  }

  @override
  Future<void> empty() async {
    await _queryAdapter.queryNoReturn('delete FROM ChannelMessage');
  }

  @override
  Future<void> addMessage(ChannelMessage message) async {
    await _channelMessageInsertionAdapter.insert(
        message, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IChannelMediaDAO extends IChannelMediaDAO {
  _$IChannelMediaDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mediaInsertionAdapter = InsertionAdapter(
            database,
            'Media',
            (Media item) => <String, dynamic>{
                  'id': item.id,
                  'type': item.type,
                  'src': item.src,
                  'leading': item.leading,
                  'msgid': item.msgid,
                  'text': item.text
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _microAppMapper = (Map<String, dynamic> row) => MicroApp(
      row['id'] as String, row['site'] as String, row['leading'] as String);

  final InsertionAdapter<Media> _mediaInsertionAdapter;

  @override
  Future<void> removeMedia(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM Media WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<MicroApp>> pageMedia(int pageSize, int currPage) async {
    return _queryAdapter.queryList('SELECT * FROM Media LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage], mapper: _microAppMapper);
  }

  @override
  Future<MicroApp> getMedia(String id) async {
    return _queryAdapter.query('SELECT * FROM Media WHERE id = ?',
        arguments: <dynamic>[id], mapper: _microAppMapper);
  }

  @override
  Future<List<MicroApp>> getAllMedia() async {
    return _queryAdapter.queryList('SELECT * FROM Media',
        mapper: _microAppMapper);
  }

  @override
  Future<void> addMedia(Media media) async {
    await _mediaInsertionAdapter.insert(media, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IChannelLikePersonDAO extends IChannelLikePersonDAO {
  _$IChannelLikePersonDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _likePersonInsertionAdapter = InsertionAdapter(
            database,
            'LikePerson',
            (LikePerson item) => <String, dynamic>{
                  'id': item.id,
                  'person': item.person,
                  'uid': item.uid,
                  'avatar': item.avatar,
                  'msgid': item.msgid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _likePersonMapper = (Map<String, dynamic> row) => LikePerson(
      row['id'] as String,
      row['person'] as String,
      row['uid'] as String,
      row['avatar'] as String,
      row['msgid'] as String);

  final InsertionAdapter<LikePerson> _likePersonInsertionAdapter;

  @override
  Future<void> removeLikePerson(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM LikePerson WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<LikePerson>> pageLikePerson(int pageSize, int currPage) async {
    return _queryAdapter.queryList('SELECT * FROM LikePerson LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage], mapper: _likePersonMapper);
  }

  @override
  Future<LikePerson> getLikePerson(String id) async {
    return _queryAdapter.query('SELECT * FROM LikePerson WHERE id = ?',
        arguments: <dynamic>[id], mapper: _likePersonMapper);
  }

  @override
  Future<List<LikePerson>> getAllLikePerson() async {
    return _queryAdapter.queryList('SELECT * FROM LikePerson',
        mapper: _likePersonMapper);
  }

  @override
  Future<void> addLikePerson(LikePerson likePerson) async {
    await _likePersonInsertionAdapter.insert(
        likePerson, sqflite.ConflictAlgorithm.abort);
  }
}

class _$IChannelCommentDAO extends IChannelCommentDAO {
  _$IChannelCommentDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _channelCommentInsertionAdapter = InsertionAdapter(
            database,
            'ChannelComment',
            (ChannelComment item) => <String, dynamic>{
                  'id': item.id,
                  'person': item.person,
                  'uid': item.uid,
                  'avatar': item.avatar,
                  'msgid': item.msgid,
                  'text': item.text,
                  'ctime': item.ctime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _channelCommentMapper = (Map<String, dynamic> row) =>
      ChannelComment(
          row['id'] as String,
          row['person'] as String,
          row['uid'] as String,
          row['avatar'] as String,
          row['msgid'] as String,
          row['text'] as String,
          row['ctime'] as int);

  final InsertionAdapter<ChannelComment> _channelCommentInsertionAdapter;

  @override
  Future<void> removeComment(String id) async {
    await _queryAdapter.queryNoReturn('delete FROM ChannelComment WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<List<ChannelComment>> pageComment(int pageSize, int currPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ChannelComment LIMIT ? OFFSET ?',
        arguments: <dynamic>[pageSize, currPage],
        mapper: _channelCommentMapper);
  }

  @override
  Future<ChannelComment> getComment(String id) async {
    return _queryAdapter.query('SELECT * FROM ChannelComment WHERE id = ?',
        arguments: <dynamic>[id], mapper: _channelCommentMapper);
  }

  @override
  Future<List<ChannelComment>> getAllComment() async {
    return _queryAdapter.queryList('SELECT * FROM ChannelComment',
        mapper: _channelCommentMapper);
  }

  @override
  Future<void> addComment(ChannelComment comment) async {
    await _channelCommentInsertionAdapter.insert(
        comment, sqflite.ConflictAlgorithm.abort);
  }
}
