import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/firebase_Utils.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/list_provider.dart';

import '../../providers/app_config_provider.dart';

class Add_Bottom_sheet extends StatefulWidget {
  @override
  State<Add_Bottom_sheet> createState() => _Add_Bottom_sheetState();
}

class _Add_Bottom_sheetState extends State<Add_Bottom_sheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);

    return Container(
      color: provider.appTheme == ThemeMode.dark
          ? MyTheme.blackDarkColor
          : MyTheme.whiteColor,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: provider.appTheme == ThemeMode.dark
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_task_title;
                    }
                    return null;
                  },
                  onChanged: (text) {
                    title = text;
                  },
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.isDarkMode()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                      ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    hintText: AppLocalizations.of(context)!.enter_task_title,
                    hintStyle: TextStyle(color: MyTheme.grayColor),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_task_description;
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.isDarkMode()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                      ),
                  onChanged: (text) {
                    description = text;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      hintText:
                          AppLocalizations.of(context)!.enter_task_description,
                      hintStyle: TextStyle(color: MyTheme.grayColor)),
                  maxLines: 3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: provider.appTheme == ThemeMode.dark
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      ShowCallender();
                    },
                    child: Text(
                      '${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: provider.appTheme == ThemeMode.dark
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.1,
                            MediaQuery.of(context).size.width * 0.05),
                        backgroundColor: MyTheme.primaryColor,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: MyTheme.whiteColor,
                            width: 3,
                          ),
                        )),
                    onPressed: () {
                      addTask();
                    },
                    child: Icon(
                      Icons.check,
                      size: 50,
                      color: MyTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void ShowCallender() async {
    var chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void addTask() {
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);
    var provider = Provider.of<AppConfigProvider>(context, listen: false);

    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.loading,
        provider: provider,
        isDismissible: false,
      );
      Task task =
          Task(title: title, description: description, datetime: selectedDate);
      FirebaseUtils.addTaskToFireStore(task, authProvider.currentUser!.id!)
          .then((value) {
        Navigator.pop(context);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          provider: provider,
          context: context,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.task_added_Successfully,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: () {},
        );
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      }).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          Navigator.pop(context);
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            provider: provider,
            context: context,
            message: AppLocalizations.of(context)!.task_added_Successfully,
            title: AppLocalizations.of(context)!.success,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {},
          );
          listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);

          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       backgroundColor: provider.isDarkMode()
          //           ? MyTheme.blackDarkColor
          //           : MyTheme.whiteColor,
          //       contentPadding: EdgeInsets.all(30),
          //       content: Text('Task Added Successfully',
          //           style: Theme.of(context)
          //               .textTheme
          //               .titleMedium!
          //               .copyWith(color: MyTheme.primaryColor)),
          //       actions: [
          //         TextButton(
          //           child: Text(
          //             'Ok',
          //             style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //                   color: MyTheme.grayColor,
          //                 ),
          //           ),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // );
        },
      );
    }
  }
}
