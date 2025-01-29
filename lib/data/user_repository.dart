import 'user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UsersRepository {
  UsersRepository._();

  static UsersRepository? _instance;

  static UsersRepository get instance {
    _instance ??= UsersRepository._();
    return _instance!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            password TEXT NOT NULL,
            loggenIn BOOLEAN NOT NULL
          );
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> createLocalAccount(User user) async {
    final db = await initDatabase();

    user.encryptPassword();

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> loginLocalAccount(User user) async {
    final userExist = await getLocalAccount(user.username);

    if (userExist == null) return false;

    user.encryptPassword();

    if (userExist.username != user.username || userExist.password != user.password) {
      return false;
    }

    final db = await initDatabase();

    user.loggenIn = 1;

    await db.update(
      'users',
      user.toMap(),
      where: 'username = ?',
      whereArgs: [user.username],
    );

    return true;
  }

  Future<void> logoutLocalAccount(User user) async {
    final db = await initDatabase();

    user.loggenIn = 0;

    await db.update(
      'users',
      user.toMap(),
      where: 'username = ?',
      whereArgs: [user.username],
    );
  }

  Future<User?> getLocalAccount(String username) async {
    final db = await initDatabase();

    List<Map> result = await db.rawQuery('SELECT * FROM users WHERE username=?', [username]);

    User? user;
    for (var row in result) {
      user = User(
        row['username'],
        row['password'],
        row['loggenIn'],
      );
    }

    return user;
  }
}
