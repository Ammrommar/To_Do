import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/home_screen.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/auth/register/custom_textfield.dart';
import 'package:to_do/auth/register/register_navigator.dart';
import 'package:to_do/auth/register/register_screen_viewmodel.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/providers/app_config_provider.dart';
import 'package:to_do/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: 'amr');
  TextEditingController emailController =
      TextEditingController(text: 'amr@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');
  bool passwordScure = true;
  bool confirmPasswordScure = true;
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

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
                AppLocalizations.of(context)!.create_account,
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
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22,
                          ),
                          CustomTextField(
                            labelText: AppLocalizations.of(context)!.user_name,
                            icon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.person)),
                            secureText: false,
                            controller: nameController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_user_name;
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            labelText: AppLocalizations.of(context)!.email,
                            icon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.email),
                            ),
                            secureText: false,
                            keyBoardType: TextInputType.emailAddress,
                            controller: emailController,
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
                                  passwordScure = !passwordScure;
                                  setState(() {});
                                },
                                icon: passwordScure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility_rounded)),
                            secureText: passwordScure,
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_your_password;
                              }
                              if (text.length < 6) {
                                return AppLocalizations.of(context)!
                                    .please_should_be_at_least_6_chars;
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            labelText:
                                AppLocalizations.of(context)!.confirm_password,
                            icon: IconButton(
                              onPressed: () {
                                confirmPasswordScure = !confirmPasswordScure;
                                setState(() {});
                              },
                              icon: confirmPasswordScure
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility_rounded),
                            ),
                            secureText: confirmPasswordScure,
                            controller: confirmPasswordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_confirm_your_password;
                              }
                              if (text != passwordController.text) {
                                return AppLocalizations.of(context)!
                                    .confirm_password_does_not_match_password;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
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
                          Register();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: provider.appTheme == ThemeMode.dark
                                        ? MyTheme.blackDarkColor
                                        : MyTheme.whiteColor,
                                  ),
                        ),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  void Register() async {
    if (formKey.currentState!.validate() == true) {
      viewModel.register(emailController.text, passwordController.text,
          nameController.text, context);
    }
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
