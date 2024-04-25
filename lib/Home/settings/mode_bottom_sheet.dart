import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';

import '../../providers/app_config_provider.dart';

class ModeBottomSheet extends StatefulWidget {
  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: provider.appTheme == ThemeMode.dark
              ? MyTheme.blackDarkColor
              : MyTheme.whiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeThemeMode(ThemeMode.light);
            },
            child: provider.isDarkMode()
                ? unSelectedModeItem(AppLocalizations.of(context)!.light)
                : SelectedModeItem(AppLocalizations.of(context)!.light),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.changeThemeMode(ThemeMode.dark);
            },
            child: provider.isDarkMode()
                ? SelectedModeItem(AppLocalizations.of(context)!.dark)
                : unSelectedModeItem(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }

  Widget SelectedModeItem(text) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: MyTheme.primaryColor, fontSize: 30),
      ),
      Icon(
        Icons.check,
        size: 40,
        color: MyTheme.primaryColor,
      )
    ]);
  }

  Widget unSelectedModeItem(text) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: provider.appTheme == ThemeMode.dark
              ? MyTheme.whiteColor
              : MyTheme.blackColor,
          fontSize: 30),
    );
  }
}
