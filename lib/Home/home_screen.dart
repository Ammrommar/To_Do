import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/settings/settings.dart';
import 'package:to_do/Home/task_list/add_bottom_sheet.dart';
import 'package:to_do/Home/task_list/task_list.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/auth/login/login_screen.dart';
import 'package:to_do/providers/app_config_provider.dart';
import 'package:to_do/providers/auth_provider.dart';

class home_Screen extends StatefulWidget {
  static const String routeName = 'Home_Screen';

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviderr>(context);
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          '${AppLocalizations.of(context)!.to_do_list} {${authProvider.currentUser?.name ?? ''}}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(
                Icons.logout,
                color: provider.appTheme == ThemeMode.dark
                    ? MyTheme.blackDarkColor
                    : MyTheme.whiteColor,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBotttomSheet();
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: MyTheme.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          iconSize: 28,
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.task_list,
              icon: ImageIcon(AssetImage('assets/images/icon_list.png')),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.settings,
              icon: ImageIcon(AssetImage('assets/images/icon_settings.png')),
            ),
          ],
        ),
      ),
      body: selectedIndex == 0 ? Task_list() : settings(),
    );
  }

  void showAddBotttomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Add_Bottom_sheet(),
    );
  }

// List<Widget> list = [Task_list(), settings()];
}
