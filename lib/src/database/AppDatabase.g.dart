// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

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
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
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

  UserDao _userDaoInstance;

  FAQDao _faqDaoInstance;

  FAQTopicDao _faqTopicDaoInstance;

  CompanyDao _companyDaoInstance;

  DataUpdateDao _dataUpdateDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
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
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER, `firstName` TEXT, `lastName` TEXT, `emailAddress` TEXT, `phoneNumber` TEXT, `photo` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `faqs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `topicId` INTEGER, `title` TEXT, `body` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `faq_topics` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `topicId` INTEGER, `title` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `updates` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `model` TEXT, `timestamp` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `companies` (`name` TEXT, `photo` TEXT, `background` TEXT, `chatIntro` TEXT, `description` TEXT, PRIMARY KEY (`name`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  FAQDao get faqDao {
    return _faqDaoInstance ??= _$FAQDao(database, changeListener);
  }

  @override
  FAQTopicDao get faqTopicDao {
    return _faqTopicDaoInstance ??= _$FAQTopicDao(database, changeListener);
  }

  @override
  CompanyDao get companyDao {
    return _companyDaoInstance ??= _$CompanyDao(database, changeListener);
  }

  @override
  DataUpdateDao get dataUpdateDao {
    return _dataUpdateDaoInstance ??= _$DataUpdateDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _tellamUserInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (TellamUser item) => <String, dynamic>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'emailAddress': item.emailAddress,
                  'phoneNumber': item.phoneNumber,
                  'photo': item.photo
                },
            changeListener),
        _tellamUserUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (TellamUser item) => <String, dynamic>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'emailAddress': item.emailAddress,
                  'phoneNumber': item.phoneNumber,
                  'photo': item.photo
                },
            changeListener),
        _tellamUserDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (TellamUser item) => <String, dynamic>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'emailAddress': item.emailAddress,
                  'phoneNumber': item.phoneNumber,
                  'photo': item.photo
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _usersMapper = (Map<String, dynamic> row) => TellamUser(
      id: row['id'] as int,
      firstName: row['firstName'] as String,
      lastName: row['lastName'] as String,
      emailAddress: row['emailAddress'] as String,
      phoneNumber: row['phoneNumber'] as String,
      photo: row['photo'] as String);

  final InsertionAdapter<TellamUser> _tellamUserInsertionAdapter;

  final UpdateAdapter<TellamUser> _tellamUserUpdateAdapter;

  final DeletionAdapter<TellamUser> _tellamUserDeletionAdapter;

  @override
  Future<TellamUser> getCurrentUser() async {
    return _queryAdapter.query('SELECT * FROM users LIMIT 1',
        mapper: _usersMapper);
  }

  @override
  Stream<TellamUser> findUserById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM users WHERE id = ?',
        arguments: <dynamic>[id], tableName: 'users', mapper: _usersMapper);
  }

  @override
  Stream<TellamUser> getCurrentUserStream() {
    return _queryAdapter.queryStream('SELECT * FROM users LIMIT 1',
        tableName: 'users', mapper: _usersMapper);
  }

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM users');
  }

  @override
  Future<void> insertUser(TellamUser user) async {
    await _tellamUserInsertionAdapter.insert(
        user, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateUser(TellamUser user) async {
    await _tellamUserUpdateAdapter.update(
        user, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteUser(TellamUser user) async {
    await _tellamUserDeletionAdapter.delete(user);
  }
}

class _$FAQDao extends FAQDao {
  _$FAQDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _fAQInsertionAdapter = InsertionAdapter(
            database,
            'faqs',
            (FAQ item) => <String, dynamic>{
                  'id': item.id,
                  'topicId': item.topicId,
                  'title': item.title,
                  'body': item.body
                },
            changeListener),
        _fAQUpdateAdapter = UpdateAdapter(
            database,
            'faqs',
            ['id'],
            (FAQ item) => <String, dynamic>{
                  'id': item.id,
                  'topicId': item.topicId,
                  'title': item.title,
                  'body': item.body
                },
            changeListener),
        _fAQDeletionAdapter = DeletionAdapter(
            database,
            'faqs',
            ['id'],
            (FAQ item) => <String, dynamic>{
                  'id': item.id,
                  'topicId': item.topicId,
                  'title': item.title,
                  'body': item.body
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _faqsMapper = (Map<String, dynamic> row) => FAQ(
      id: row['id'] as int,
      topicId: row['topicId'] as int,
      title: row['title'] as String,
      body: row['body'] as String);

  final InsertionAdapter<FAQ> _fAQInsertionAdapter;

  final UpdateAdapter<FAQ> _fAQUpdateAdapter;

  final DeletionAdapter<FAQ> _fAQDeletionAdapter;

  @override
  Future<List<FAQ>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM faqs ORDER BY id DESC',
        mapper: _faqsMapper);
  }

  @override
  Stream<FAQ> findById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM faqs WHERE id = ?',
        arguments: <dynamic>[id], tableName: 'faqs', mapper: _faqsMapper);
  }

  @override
  Stream<List<FAQ>> findByTopicId(int topicId) {
    return _queryAdapter.queryListStream('SELECT * FROM faqs WHERE topicId = ?',
        arguments: <dynamic>[topicId], tableName: 'faqs', mapper: _faqsMapper);
  }

  @override
  Stream<List<FAQ>> findAllStream() {
    return _queryAdapter.queryListStream('SELECT * FROM faqs ORDER BY id DESC',
        tableName: 'faqs', mapper: _faqsMapper);
  }

  @override
  Stream<List<FAQ>> findPopularStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM faqs ORDER BY id DESC LIMIT 4',
        tableName: 'faqs',
        mapper: _faqsMapper);
  }

  @override
  Future<void> deleteAllFAQs() async {
    await _queryAdapter.queryNoReturn('DELETE FROM faqs');
  }

  @override
  Future<void> insertFAQ(FAQ faq) async {
    await _fAQInsertionAdapter.insert(faq, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertFAQs(List<FAQ> faqs) {
    return _fAQInsertionAdapter.insertListAndReturnIds(
        faqs, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateFAQ(FAQ faq) async {
    await _fAQUpdateAdapter.update(faq, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteFAQ(FAQ faq) async {
    await _fAQDeletionAdapter.delete(faq);
  }

  @override
  Future<void> replaceFAQs(List<FAQ> faqs) async {
    if (database is sqflite.Transaction) {
      await super.replaceFAQs(faqs);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.faqDao.replaceFAQs(faqs);
      });
    }
  }
}

class _$FAQTopicDao extends FAQTopicDao {
  _$FAQTopicDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _fAQTopicInsertionAdapter = InsertionAdapter(
            database,
            'faq_topics',
            (FAQTopic item) => <String, dynamic>{
                  'id': item.id,
                  'topicId': item.topicId,
                  'title': item.title
                },
            changeListener),
        _fAQTopicUpdateAdapter = UpdateAdapter(
            database,
            'faq_topics',
            ['id'],
            (FAQTopic item) => <String, dynamic>{
                  'id': item.id,
                  'topicId': item.topicId,
                  'title': item.title
                },
            changeListener),
        _fAQTopicDeletionAdapter = DeletionAdapter(
            database,
            'faq_topics',
            ['id'],
            (FAQTopic item) => <String, dynamic>{
                  'id': item.id,
                  'topicId': item.topicId,
                  'title': item.title
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _faq_topicsMapper = (Map<String, dynamic> row) =>
      FAQTopic(topicId: row['topicId'] as int, title: row['title'] as String);

  final InsertionAdapter<FAQTopic> _fAQTopicInsertionAdapter;

  final UpdateAdapter<FAQTopic> _fAQTopicUpdateAdapter;

  final DeletionAdapter<FAQTopic> _fAQTopicDeletionAdapter;

  @override
  Future<List<FAQTopic>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM faq_topics ORDER BY id DESC',
        mapper: _faq_topicsMapper);
  }

  @override
  Stream<FAQTopic> findById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM faq_topics WHERE id = ?',
        arguments: <dynamic>[id],
        tableName: 'faq_topics',
        mapper: _faq_topicsMapper);
  }

  @override
  Stream<List<FAQTopic>> findAllStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM faq_topics ORDER BY id DESC',
        tableName: 'faq_topics',
        mapper: _faq_topicsMapper);
  }

  @override
  Future<void> deleteAllFAQTopics() async {
    await _queryAdapter.queryNoReturn('DELETE FROM faq_topics');
  }

  @override
  Future<void> insertFAQTopic(FAQTopic faqTopic) async {
    await _fAQTopicInsertionAdapter.insert(
        faqTopic, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertFAQTopics(List<FAQTopic> faqTopics) {
    return _fAQTopicInsertionAdapter.insertListAndReturnIds(
        faqTopics, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateFAQTopic(FAQTopic faqTopic) async {
    await _fAQTopicUpdateAdapter.update(
        faqTopic, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteFAQTopic(FAQTopic faqTopic) async {
    await _fAQTopicDeletionAdapter.delete(faqTopic);
  }

  @override
  Future<void> replaceFAQTopics(List<FAQTopic> faqTopics) async {
    if (database is sqflite.Transaction) {
      await super.replaceFAQTopics(faqTopics);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.faqTopicDao.replaceFAQTopics(faqTopics);
      });
    }
  }
}

class _$CompanyDao extends CompanyDao {
  _$CompanyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _companyInsertionAdapter = InsertionAdapter(
            database,
            'companies',
            (Company item) => <String, dynamic>{
                  'name': item.name,
                  'photo': item.photo,
                  'background': item.background,
                  'chatIntro': item.chatIntro,
                  'description': item.description
                },
            changeListener),
        _companyUpdateAdapter = UpdateAdapter(
            database,
            'companies',
            ['name'],
            (Company item) => <String, dynamic>{
                  'name': item.name,
                  'photo': item.photo,
                  'background': item.background,
                  'chatIntro': item.chatIntro,
                  'description': item.description
                },
            changeListener),
        _companyDeletionAdapter = DeletionAdapter(
            database,
            'companies',
            ['name'],
            (Company item) => <String, dynamic>{
                  'name': item.name,
                  'photo': item.photo,
                  'background': item.background,
                  'chatIntro': item.chatIntro,
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _companiesMapper = (Map<String, dynamic> row) => Company(
      name: row['name'] as String,
      photo: row['photo'] as String,
      background: row['background'] as String,
      chatIntro: row['chatIntro'] as String,
      description: row['description'] as String);

  final InsertionAdapter<Company> _companyInsertionAdapter;

  final UpdateAdapter<Company> _companyUpdateAdapter;

  final DeletionAdapter<Company> _companyDeletionAdapter;

  @override
  Future<Company> getCurrentCompany() async {
    return _queryAdapter.query('SELECT * FROM companies LIMIT 1',
        mapper: _companiesMapper);
  }

  @override
  Stream<Company> getCurrentCompanyStream() {
    return _queryAdapter.queryStream('SELECT * FROM companies LIMIT 1',
        tableName: 'companies', mapper: _companiesMapper);
  }

  @override
  Future<void> deleteAllCompanies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM companies');
  }

  @override
  Future<void> insertCompany(Company company) async {
    await _companyInsertionAdapter.insert(
        company, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateCompany(Company company) async {
    await _companyUpdateAdapter.update(
        company, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteCompany(Company company) async {
    await _companyDeletionAdapter.delete(company);
  }
}

class _$DataUpdateDao extends DataUpdateDao {
  _$DataUpdateDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _dataUpdateInsertionAdapter = InsertionAdapter(
            database,
            'updates',
            (DataUpdate item) => <String, dynamic>{
                  'id': item.id,
                  'model': item.model,
                  'timestamp': item.timestamp
                },
            changeListener),
        _dataUpdateUpdateAdapter = UpdateAdapter(
            database,
            'updates',
            ['id'],
            (DataUpdate item) => <String, dynamic>{
                  'id': item.id,
                  'model': item.model,
                  'timestamp': item.timestamp
                },
            changeListener),
        _dataUpdateDeletionAdapter = DeletionAdapter(
            database,
            'updates',
            ['id'],
            (DataUpdate item) => <String, dynamic>{
                  'id': item.id,
                  'model': item.model,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _updatesMapper = (Map<String, dynamic> row) => DataUpdate(
      id: row['id'] as int,
      model: row['model'] as String,
      timestamp: row['timestamp'] as String);

  final InsertionAdapter<DataUpdate> _dataUpdateInsertionAdapter;

  final UpdateAdapter<DataUpdate> _dataUpdateUpdateAdapter;

  final DeletionAdapter<DataUpdate> _dataUpdateDeletionAdapter;

  @override
  Future<List<DataUpdate>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM updates ORDER BY id DESC',
        mapper: _updatesMapper);
  }

  @override
  Future<DataUpdate> findLast() async {
    return _queryAdapter.query('SELECT * FROM updates ORDER BY id DESC LIMIT 1',
        mapper: _updatesMapper);
  }

  @override
  Stream<DataUpdate> findById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM updates WHERE id = ?',
        arguments: <dynamic>[id], tableName: 'updates', mapper: _updatesMapper);
  }

  @override
  Stream<List<DataUpdate>> findAllStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM updates ORDER BY id DESC',
        tableName: 'updates',
        mapper: _updatesMapper);
  }

  @override
  Future<void> deleteAllDataUpdates() async {
    await _queryAdapter.queryNoReturn('DELETE FROM updates');
  }

  @override
  Future<void> insertDataUpdate(DataUpdate dataUpdate) async {
    await _dataUpdateInsertionAdapter.insert(
        dataUpdate, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateDataUpdate(DataUpdate dataUpdate) async {
    await _dataUpdateUpdateAdapter.update(
        dataUpdate, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteDataUpdate(DataUpdate dataUpdate) async {
    await _dataUpdateDeletionAdapter.delete(dataUpdate);
  }
}
