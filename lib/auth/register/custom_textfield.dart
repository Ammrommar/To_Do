import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/providers/app_config_provider.dart';

class CustomTextField extends StatelessWidget {
  String labelText;
  TextInputType keyBoardType;
  String? Function(String?) validator;
  IconButton icon;
  bool secureText;
  TextEditingController controller;

  CustomTextField(
      {required this.labelText,
      required this.validator,
      required this.secureText,
      required this.icon,
      this.keyBoardType = TextInputType.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          labelText: labelText,
          suffixIcon: icon,
          suffixIconColor: MyTheme.primaryColor,
          labelStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: MyTheme.grayColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: MyTheme.primaryColor, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: MyTheme.primaryColor, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: MyTheme.redColor, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: MyTheme.redColor, width: 2)),
        ),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: provider.appTheme == ThemeMode.dark
                  ? MyTheme.whiteColor
                  : MyTheme.blackColor,
            ),
        keyboardType: keyBoardType,
        controller: controller,
        validator: validator,
        obscureText: secureText,
        obscuringCharacter: '*',
      ),
    );
  }
}
