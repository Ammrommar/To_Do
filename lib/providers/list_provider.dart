import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/firebase_Utils.dart';
import 'package:to_do/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void changeSelectedDate(DateTime newSelectedDate, String uId) {
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore(uId);
  }

  getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTaskCollection(uId).get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((task) {
      if (selectedDate.day == task.datetime!.day &&
          selectedDate.month == task.datetime!.month &&
          selectedDate.year == task.datetime!.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((task1, task2) {
      return task1.datetime!.compareTo(task2.datetime!);
    });
    notifyListeners();
  }
}
