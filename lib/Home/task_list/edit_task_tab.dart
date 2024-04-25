import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/home_screen.dart';
import 'package:to_do/Home/task_list/task_item.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/providers/app_config_provider.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/list_provider.dart';

import '../../firebase_Utils.dart';

class EditTaskTab extends StatefulWidget {
  static const String routeName = 'Edit_Task_Tab';

  @override
  State<EditTaskTab> createState() => _EditTaskTabState();
}

class _EditTaskTabState extends State<EditTaskTab> {
  var formKey = GlobalKey<FormState>();
  DateTime? newSelectedDate;
  String? newTitle;
  String? newDescription;
  String? taskId;

  // late DateTime newSelectedDate;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as taskArguments;
    if (newSelectedDate == null && args.selectedDate != null) {
      newSelectedDate = args.selectedDate;
    }
    newDescription ??= args.description;
    newTitle ??= args.title;
    newSelectedDate ??= args.selectedDate;
    taskId = args.taskId;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text(
            AppLocalizations.of(context)!.edit_task,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: provider.appTheme == ThemeMode.dark
                ? MyTheme.blackDarkColor
                : MyTheme.whiteColor,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.edit_task,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: provider.appTheme == ThemeMode.dark
                          ? MyTheme.whiteColor
                          : MyTheme.blackColor,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: provider.appTheme == ThemeMode.dark
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor,
                          ),
                      // controller: titleController,
                      initialValue: '${args.title}',

                      onChanged: (text) {
                        newTitle = text;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyTheme.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MyTheme.primaryColor, width: 3),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        hintText:
                            AppLocalizations.of(context)!.enter_task_title,
                        hintStyle: TextStyle(color: MyTheme.grayColor),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_task_description;
                        }
                        return null;
                      },
                      onChanged: (text) {
                        newDescription = text;
                      },
                      // controller: decriptionController,
                      initialValue: '${args.description}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: provider.appTheme == ThemeMode.dark
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor,
                          ),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MyTheme.primaryColor, width: 3),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          hintText: AppLocalizations.of(context)!
                              .enter_task_description,
                          hintStyle: TextStyle(color: MyTheme.grayColor)),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
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
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          ShowCallender();
                        },
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(newSelectedDate!),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: provider.appTheme == ThemeMode.dark
                                        ? MyTheme.whiteColor
                                        : MyTheme.blackColor,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(12),
                              backgroundColor: MyTheme.primaryColor,
                              shape: StadiumBorder()),
                          onPressed: () {
                            editTask();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.save_changes,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: provider.appTheme == ThemeMode.dark
                                      ? MyTheme.blackDarkColor
                                      : MyTheme.whiteColor,
                                ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void ShowCallender() async {
    var chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      newSelectedDate = chosenDate;
    }
    setState(() {});
  }

  void editTask() {
    var provider = Provider.of<AppConfigProvider>(context, listen: false);
    var listProvider = Provider.of<ListProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);

    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.loading,
        provider: provider,
        isDismissible: false,
      );
      FirebaseUtils.updateTaskInFireStore(
        id: taskId,
        uId: taskId!,
        newTitle: newTitle,
        newDate: newSelectedDate!,
        newDescription: newDescription,
      ).then((value) {
        DialogUtils.hideLoading(context);
        // Navigator.pop(context);
        DialogUtils.showMessage(
          context: context,
          provider: provider,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.task_edited_Successfully,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: () {
            print('task edited');
            Navigator.popAndPushNamed(context, home_Screen.routeName,
                arguments: EditedTaskArguments(
                  newTitle: newTitle!,
                  newDescription: newDescription!,
                  newSelectedDate: newSelectedDate!,
                ));
          },
        );
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      }).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          // Navigator.pop(context);
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            provider: provider,
            title: AppLocalizations.of(context)!.success,
            message: AppLocalizations.of(context)!.task_added_Successfully,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.popAndPushNamed(context, home_Screen.routeName);
            },
          );
          listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        },
      );
    }
  }
}

class EditedTaskArguments {
  String newTitle;
  String newDescription;
  DateTime newSelectedDate;

  EditedTaskArguments({
    required this.newTitle,
    required this.newDescription,
    required this.newSelectedDate,
  });
}
