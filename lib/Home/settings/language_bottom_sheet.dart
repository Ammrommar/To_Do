import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
              provider.changelanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? SelectedLanguageItem(
                    AppLocalizations.of(context)!.english, context)
                : unSelectedLanguageItem(
                    AppLocalizations.of(context)!.english, context),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.changelanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? SelectedLanguageItem(
                    AppLocalizations.of(context)!.arabic, context)
                : unSelectedLanguageItem(
                    AppLocalizations.of(context)!.arabic, context),
          ),
        ],
      ),
    );
  }

  Widget SelectedLanguageItem(text, context) {
    var provider = Provider.of<AppConfigProvider>(context);
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

  Widget unSelectedLanguageItem(text, context) {
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
