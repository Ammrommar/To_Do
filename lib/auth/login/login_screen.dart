import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/home_screen.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/auth/login/login_navigator.dart';
import 'package:to_do/auth/login/login_screen_viewmodel.dart';
import 'package:to_do/auth/register/custom_textfield.dart';
import 'package:to_do/auth/register/register_screen.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/providers/app_config_provider.dart';
import 'package:to_do/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginScreenViewModel viewModel = LoginScreenViewModel();
  bool passwordSecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: provider.appTheme == ThemeMode.dark
                ? MyTheme.blackDarkColor
                : MyTheme.whiteColor,
            child: Image.asset('assets/images/background.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: provider.appTheme == ThemeMode.dark
                          ? MyTheme.blackDarkColor
                          : MyTheme.whiteColor,
                    ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22,
                          ),
                          Text(
                            AppLocalizations.of(context)!.welcome_back,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: MyTheme.primaryColor,
                                ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          CustomTextField(
                            labelText: AppLocalizations.of(context)!.email,
                            icon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.email)),
                            secureText: false,
                            keyBoardType: TextInputType.emailAddress,
                            controller: viewModel.emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_your_email;
                              }
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return AppLocalizations.of(context)!
                                    .please_enter_valid_email;
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            labelText: AppLocalizations.of(context)!.password,
                            icon: IconButton(
                                onPressed: () {
                                  passwordSecure = !passwordSecure;
                                  setState(() {});
                                },
                                icon: passwordSecure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            secureText: passwordSecure,
                            controller: viewModel.passwordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_your_password;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: MyTheme.primaryColor),
                        onPressed: () {
                          viewModel.login(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: provider.appTheme == ThemeMode.dark
                                        ? MyTheme.blackDarkColor
                                        : MyTheme.whiteColor,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: provider.appTheme == ThemeMode.dark
                                  ? MyTheme.blackDarkColor
                                  : MyTheme.whiteColor,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.or_create_account,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.primaryColor),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading() {
    var provider = Provider.of<AppConfigProvider>(context, listen: false);

    // TODO: implement showMyLoading
    DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.loading,
        provider: provider);
  }

  @override
  void showMyMessage(String message) {
    var provider = Provider.of<AppConfigProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);
    // TODO: implement showMyMessage
    DialogUtils.showMessage(
        context: context,
        message: message,
        provider: provider,
        posActionName: 'Ok',
        posAction: authProvider.currentUser?.id != null
            ? () {
                Navigator.of(context)
                    .pushReplacementNamed(home_Screen.routeName);
              }
            : () {});
  }
}
