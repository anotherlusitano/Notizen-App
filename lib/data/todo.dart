class Todo {
  int id;
  String name;
  String category;
  int isDone = 0;

  Todo(this.id, this.name, this.category, this.isDone);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return 'Note(id: $id, name: $name, category: $category, isDone: $isDone)';
  }
}
