import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/task_list/task_item.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/providers/app_config_provider.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/list_provider.dart';

class Task_list extends StatefulWidget {
  @override
  State<Task_list> createState() => _Task_listState();
}

class _Task_listState extends State<Task_list> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviderr>(context);
    if (listProvider.taskList.isEmpty) {
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        children: [
          Container(
            color: provider.appTheme == ThemeMode.dark
                ? MyTheme.blackDarkColor
                : MyTheme.whiteColor,
            child: EasyDateTimeLine(
              locale: provider.appLanguage,
              initialDate: listProvider.selectedDate,
              onDateChange: (date) {
                //`selectedDate` the new date selected.
                listProvider.changeSelectedDate(
                    date, authProvider.currentUser!.id!);
              },
              headerProps: EasyHeaderProps(
                selectedDateStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(
                        color: provider.appTheme == ThemeMode.dark
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor),
                monthStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: provider.appTheme == ThemeMode.dark
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor),
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              dayProps: EasyDayProps(
                todayStyle: DayStyle(
                    dayStrStyle: TextStyle(
                        color: provider.appTheme == ThemeMode.dark
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor),
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            color: provider.appTheme == ThemeMode.dark
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor)),
                inactiveDayStyle: DayStyle(
                    dayStrStyle: TextStyle(
                        color: provider.appTheme == ThemeMode.dark
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor),
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            color: provider.appTheme == ThemeMode.dark
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor)),
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff3371FF),
                        Color(0xff5D9CEC),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Task_Item(
                  task: listProvider.taskList[index],
                );
              },
              itemCount: listProvider.taskList.length,
            ),
          )
        ],
      ),
    );
  }
}
