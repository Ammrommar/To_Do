import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/auth/login/login_navigator.dart';
import 'package:to_do/firebase_Utils.dart';

import '../../providers/auth_provider.dart';

class LoginScreenViewModel extends ChangeNotifier {
  TextEditingController emailController =
      TextEditingController(text: 'amrr@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();

  void login(BuildContext context) async {
    if (formKey.currentState!.validate() == true) {
      try {
        navigator.showMyLoading();
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print('login Successfully');
        print(credential.user!.uid ?? '');
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<AuthProviderr>(context, listen: false);
        authProvider.updateUser(user);
        navigator.hideMyLoading();
        navigator.showMyMessage('login_successfully');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          navigator.hideMyLoading();
          navigator.showMyMessage('${e.toString()}');
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        }
      } catch (e) {
        navigator.hideMyLoading();
        navigator.showMyMessage('${e.toString()}');
        print(e.toString());
      }
    }
  }
}
