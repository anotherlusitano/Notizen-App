import 'todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodosRepository {
  TodosRepository._();

  static TodosRepository? _instance;

  static TodosRepository get instance {
    _instance ??= TodosRepository._();
    return _instance!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todos.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY NOT NULL,
            owner TEXT NOT NULL,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            isDone BOOLEAN NOT NULL
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> createTodo(Todo todo) async {
    final db = await initDatabase();

    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodoToDone(Todo todo, int todoId) async {
    final db = await initDatabase();

    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todoId],
    );
  }

  Future<void> deleteTodo(int todoId) async {
    final db = await initDatabase();

    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todoId],
    );
  }

  Future<List<Todo>> getTodos(String owner) async {
    final db = await initDatabase();

    List<Map> result = await db.rawQuery("SELECT * FROM todos WHERE owner = '$owner'");

    List<Todo> todos = [];
    for (var row in result) {
      todos.add(
        Todo(
          row['id'],
          row['owner'],
          row['name'],
          row['category'],
          row['isDone'],
        ),
      );
    }

    return todos;
  }
}
