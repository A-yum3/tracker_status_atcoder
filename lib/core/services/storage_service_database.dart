import 'dart:collection';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/utils/locator.dart';
import 'api_service.dart';
import 'storage_service.dart';

class StorageServiceDatabase extends StorageService {
  // TODO: 実際にデータベースを使用して構築する。
  final _dbHelper = DatabaseHelper.instance;
  Api _api = locator<Api>();

  @override
  Future<User> getUserData(String name) async {
    User user = await _dbHelper.getUserRow(name);
    return user;
  }

  @override
  Future<void> userDataDelete(String name) async {
    await _dbHelper.delete(name);
  }

  @override
  Future<void> userDataAllDelete() async {
    await _dbHelper.allDelete();
  }

  @override
  Future<LinkedHashMap<String, User>> getUserDataAll() async {
    List<User> userList = await _dbHelper.queryAllRows();
    LinkedHashMap<String, User> userHashMap = LinkedHashMap<String, User>();
    userList.forEach((User user) {
        userHashMap[user.userId] = user;
        print(user);
    });
    return userHashMap;
  }

  @override
  Future<User> registerUserName(String name) async {
    User user = await _api.getUserDataFromApi(name);
    if (user == null) {
      return null;
    }
    _dbHelper.insert(user);
    return user;
  }

  @override
  Future<void> updateAllUserData() async {
    List<User> userList = await _dbHelper.queryAllRows();
    userList.forEach((user) async {
      User updatedUser = await _api.getUserDataFromApi(user.userId);
      await _dbHelper.update(updatedUser);
    });
  }
}

class DatabaseHelper {
  static final _databaseName = "UserDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'users_table';

  static final columnUserId = 'user_id';
  static final columnAcceptedCount = 'accepted_count';
  static final columnRatedPointSum = 'rated_point_sum';
  static final columnAcceptedCountRank = 'accepted_count_Rank';
  static final columnRatedPointSumRank = 'rated_point_sum_rank';
  static final columnAffiliation = 'affiliation';
  static final columnBirthYear = 'birth_year';
  static final columnCompetitions = 'competitions';
  static final columnFormalCountryName = 'formal_country_name';
  static final columnHighestRating = 'highest_rating';
  static final columnRank = 'rank_atcoder';
  static final columnRating = 'rating';
  static final columnLastUpdate = 'last_update';
  static final columnColor = 'color';
  static final columnImageUrl = 'image_url';
  static final columnLastUpdateData = 'last_update_data';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Tableを作る。
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnUserId TEXT PRIMARY KEY,
            $columnAcceptedCount INTEGER NOT NULL,
            $columnRatedPointSum REAL NOT NULL,
            $columnAcceptedCountRank INTEGER NOT NULL,
            $columnRatedPointSumRank INTEGER NOT NULL,
            $columnAffiliation TEXT,
            $columnBirthYear INTEGER,
            $columnCompetitions INTEGER NOT NULL,
            $columnFormalCountryName TEXT NOT NULL,
            $columnHighestRating INTEGER NOT NULL,
            $columnRank INTEGER NOT NULL,
            $columnRating INTEGER NOT NULL,
            $columnLastUpdate NOT NULL,
            $columnColor TEXT NOT NULL,
            $columnImageUrl TEXT NOT NULL,
            $columnLastUpdateData TEXT NOT NULL
          );
          ''');
  }

  // Helper methods

  // Userで渡された形式のものをMap形式にして行として挿入する。
  Future<int> insert(User user) async {
    Database db = await instance.database;
    return await db.insert(table, user.toMap());
  }

  Future<User> getUserRow(String userId) async {
    Database db = await instance.database;
    List<Map> result = await db.query(table,
        columns: [
          columnUserId,
          columnAcceptedCount,
          columnRatedPointSum,
          columnAcceptedCountRank,
          columnRatedPointSumRank,
          columnAffiliation,
          columnBirthYear,
          columnCompetitions,
          columnFormalCountryName,
          columnHighestRating,
          columnRank,
          columnRating,
          columnLastUpdate,
          columnColor,
          columnImageUrl,
          columnLastUpdateData,
        ],
        where: '$columnUserId = ?',
        whereArgs: [userId]);

    if (result.length > 0) {
      return User.fromJson(result.first);
    }

    return null;
  }

  // すべての行を返す。リストの中にMap（JSON）の形式
  Future<List<User>> queryAllRows() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> userListMap = await db.query(table);
    List<User> userList = List<User>();
    userListMap.forEach((Map<String, dynamic> readUser) {
      // Read-Onlyのためクラッシュする。一度インスタンスを作り変える。
      Map<String, dynamic> user = Map<String, dynamic>.from(readUser);
      userList.add(User.fromJson(user));
    });

    return userList;
  }

  // 総数行の数を返す。　.lengthみたいな扱いで使える
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // UserIdが同じものを更新する。
  Future<int> update(User user) async {
    Database db = await instance.database;
    return await db.update(table, user.toMap(),
        where: '$columnUserId = ?', whereArgs: [user.userId]);
  }

  // UserIdが指定されたものを削除する。
  Future<int> delete(String userId) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '$columnUserId = ?', whereArgs: [userId]);
  }

  Future<int> allDelete() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
