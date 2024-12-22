class Item {
  final String status;
  final List<Task> data;

  Item({
    required this.status,
    required this.data,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      status: json['status'],
      data: List<Task>.from(json['data'].map((x) => Task.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Task {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
