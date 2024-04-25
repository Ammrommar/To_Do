class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? datetime;
  bool? isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.datetime,
    this.isDone = false,
  });

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String?,
          title: data['title'] as String?,
          description: data['description'] as String?,
          datetime: DateTime.fromMillisecondsSinceEpoch(data['datetime']),
          isDone: data['isDone'] as bool?,
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'datetime': datetime?.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
