class Todo {
  String name;
  String category;
  int isDone = 0;

  Todo(this.name, this.category, this.isDone);

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'category': category,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return 'Note(name: $name, category: $category, isDone: $isDone)';
  }
}
