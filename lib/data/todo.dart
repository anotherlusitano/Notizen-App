class Todo {
  int id;
  String owner;
  String name;
  String category;
  int isDone = 0;

  Todo(this.id, this.owner, this.name, this.category, this.isDone);

  Map<String, Object?> toMap() {
    return {
      'owner': owner,
      'name': name,
      'category': category,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return 'Note(id: $id, owner: $owner, name: $name, category: $category, isDone: $isDone)';
  }
}
