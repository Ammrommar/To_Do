import 'package:flutter/cupertino.dart';
import 'package:to_do/model/my_user.dart';

class AuthProviderr extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
