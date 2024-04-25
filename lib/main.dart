import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/home_screen.dart';
import 'package:to_do/Home/task_list/edit_task_tab.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/auth/login/login_screen.dart';
import 'package:to_do/auth/register/register_screen.dart';
import 'package:to_do/providers/app_config_provider.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppConfigProvider>(
        create: (_) => AppConfigProvider(),
      ),
      ChangeNotifierProvider<ListProvider>(
        create: (_) => ListProvider(),
      ),
      ChangeNotifierProvider<AuthProviderr>(
        create: (_) => AuthProviderr(),
      ),
    ],
    child: MyApp(),
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    provider.getLanguage();
    provider.getTheme();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        home_Screen.routeName: (context) => home_Screen(),
        EditTaskTab.routeName: (context) => EditTaskTab(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
    );
  }
}
