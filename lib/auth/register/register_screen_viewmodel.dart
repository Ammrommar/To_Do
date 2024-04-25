import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/auth/register/register_navigator.dart';
import 'package:to_do/firebase_Utils.dart';
import 'package:to_do/model/my_user.dart';
import 'package:to_do/providers/auth_provider.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

  void register(
      String email, String password, String name, BuildContext context) async {
    try {
      navigator.showMyLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        email: email,
        name: name,
      );
      await FirebaseUtils.addUserToFireStore(myUser);
      var authProvider = Provider.of<AuthProviderr>(context, listen: false);
      authProvider.updateUser(myUser);
      navigator.hideMyLoading();
      navigator.showMyMessage('register successfully');
      print('Account Created Successfully');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideMyLoading();
        navigator.showMyMessage('the_password_provided_is_too_weak');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideMyLoading();
        navigator.showMyMessage('the_account_already_exists_for_that_email');
      }
    } catch (e) {
      navigator.hideMyLoading();
      navigator.showMyMessage('${e.toString()}');
      print(e);
    }
  }
}
