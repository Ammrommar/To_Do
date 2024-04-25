import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/model/my_user.dart';

import 'model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task, String uId) {
    CollectionReference<Task> taskCollection = getTaskCollection(uId);
    DocumentReference<Task> taskDocref = taskCollection.doc();
    task.id = taskDocref.id;
    return taskDocref.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()),
          toFirestore: (user, _) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static Future<void> updateTaskInFireStore({
    required String? id,
    String? newTitle = '',
    String? newDescription = '',
    required DateTime newDate,
    bool? newIsDone = false,
    required String uId,
  }) async {
    final docSnapshot = await getTaskCollection(uId).doc(id).get();

    if (docSnapshot.exists) {
      await getTaskCollection(uId)
          .doc(id)
          .update({
            'title': newTitle,
            'description': newDescription,
            'dateTime': newDate,
            'isDone': newIsDone,
          })
          .then((value) => print("Task Updated"))
          .catchError((error) => print("Failed to update Task: $error"));
      print('updated');
    } else {
      print('Document with ID $id does not exist.');
    }
  }
// static Future<void> updateTaskInFireStore(
//     {required String? id,
//     String? newTitle = '',
//     String? newDescription = '',
//     required DateTime newDate,
//     bool? newIsDone = false,
//     required String uId}) async {
//   await getTaskCollection(uId)
//       .doc(id)
//       .update({
//         'title': newTitle,
//         'description': newDescription,
//         'dateTime': newDate,
//         'isDone': newIsDone,
//       })
//       .then((value) => print("Task Updated"))
//       .catchError((error) => print("Failed to update Task: $error"));
//   print('updated');
// }
}
