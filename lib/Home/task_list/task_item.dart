import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/firebase_Utils.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/list_provider.dart';

import '../../model/task.dart';
import '../../providers/app_config_provider.dart';
import 'edit_task_tab.dart';

class Task_Item extends StatefulWidget {
  Task task;

  Task_Item({required this.task});

  @override
  State<Task_Item> createState() => _Task_ItemState();
}

class _Task_ItemState extends State<Task_Item> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    // var editArgs =
    //     ModalRoute.of(context)?.settings.arguments as EditedTaskArguments;
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviderr>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    String title = widget.task.title ?? '';
    String description = widget.task.description ?? '';
    DateTime selectedDate = widget.task.datetime ?? DateTime.now();

    BuildContext validContext = context;
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: DrawerMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(16),
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(
                        widget.task, authProvider.currentUser!.id!)
                    .then((value) {
                  DialogUtils.showMessage(
                    context: validContext,
                    message: AppLocalizations.of(validContext)!
                        .task_deleted_Successfully,
                    provider: provider,
                    title: AppLocalizations.of(validContext)!.success,
                    posActionName: AppLocalizations.of(validContext)!.ok,
                    posAction: () {},
                  );
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                }).timeout(Duration(milliseconds: 500), onTimeout: () {
                  DialogUtils.showMessage(
                    provider: provider,
                    context: validContext,
                    message: AppLocalizations.of(validContext)!
                        .task_deleted_Successfully,
                    title: AppLocalizations.of(validContext)!.success,
                    posActionName: AppLocalizations.of(context)!.ok,
                    posAction: () {},
                  );
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(16),
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (context) {
                //edit the task;
                Navigator.pushNamed(context, EditTaskTab.routeName,
                    arguments: taskArguments(
                        taskId: widget.task.id!,
                        title: title,
                        description: description,
                        selectedDate: selectedDate));
              },
              backgroundColor: MyTheme.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: provider.appTheme == ThemeMode.dark
                ? MyTheme.blackDarkColor
                : MyTheme.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.012,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isDone ? MyTheme.greenColor : MyTheme.primaryColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title
                      // == editArgs.newTitle ? title : editArgs.newTitle
                      ,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: isDone
                                ? MyTheme.greenColor
                                : MyTheme.primaryColor,
                          ),
                    ),
                    Text(
                      description
                      // == editArgs.newDescription
                      // ? description
                      // : editArgs.newDescription
                      ,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: provider.appTheme == ThemeMode.dark
                                ? MyTheme.whiteColor
                                : MyTheme.grayColor,
                          ),
                    ),
                  ],
                ),
              ),
              isDone ? isDoneContainer() : notDoneContainer()
            ],
          ),
        ),
      ),
    );
  }

  Widget isDoneContainer() {
    return Container(
        child: InkWell(
      onTap: () {
        isDone = false;
      },
      child: Text(
        AppLocalizations.of(context)!.done,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: MyTheme.greenColor),
      ),
    ));
  }

  Widget notDoneContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.1,
      padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1),
      decoration: BoxDecoration(
          color: MyTheme.primaryColor, borderRadius: BorderRadius.circular(30)),
      child: IconButton(
        onPressed: () {
          isDone = true;
        },
        icon: Icon(
          Icons.check,
          size: 25,
          color: MyTheme.whiteColor,
        ),
      ),
    );
  }
}

class taskArguments {
  String title;
  String description;
  DateTime selectedDate;
  String taskId;

  taskArguments(
      {required this.title,
      required this.description,
      required this.selectedDate,
      required this.taskId});
}
