class MyUser {
  static const String collectionName = 'Users';
  String? id;
  String? email;
  String? name;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
  });

  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'] as String,
            email: data?['email'] as String,
            name: data?['name'] as String);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'email': email, 'name': name};
  }
}
