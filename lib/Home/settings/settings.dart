import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/settings/mode_bottom_sheet.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/providers/app_config_provider.dart';

import 'language_bottom_sheet.dart';

class settings extends StatefulWidget {
  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      color: provider.appTheme == ThemeMode.dark
          ? MyTheme.backgroundColorDark
          : MyTheme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.start,
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: provider.appTheme == ThemeMode.dark
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.appTheme == ThemeMode.dark
                    ? MyTheme.blackDarkColor
                    : MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.appLanguage == 'en'
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyTheme.primaryColor, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {
                      ShowLanguageBottomSheet();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: MyTheme.primaryColor,
                      size: 35,
                    ))
              ],
            ),
          ),
          Text(
            textAlign: TextAlign.start,
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: provider.appTheme == ThemeMode.dark
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.appTheme == ThemeMode.dark
                    ? MyTheme.blackDarkColor
                    : MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyTheme.primaryColor, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {
                      ShowModeBottomSheet();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: MyTheme.primaryColor,
                      size: 35,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void ShowLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },
    );
  }

  void ShowModeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModeBottomSheet();
      },
    );
  }
}
