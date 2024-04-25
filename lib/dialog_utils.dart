import 'package:flutter/material.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/providers/app_config_provider.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context,
      required String message,
      required AppConfigProvider provider,
      bool isDismissible = true}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: provider.appTheme == ThemeMode.dark
              ? MyTheme.blackDarkColor
              : MyTheme.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              CircularProgressIndicator(color: MyTheme.primaryColor),
              SizedBox(
                width: 20,
              ),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: MyTheme.primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    required AppConfigProvider provider,
    String title = '',
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
    bool isDismissible = true,
  }) {
    GlobalKey<State> key = GlobalKey<State>();
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          key: key,
          backgroundColor: provider.appTheme == ThemeMode.dark
              ? MyTheme.blackDarkColor
              : MyTheme.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            title,
            style: TextStyle(
              color: provider.appTheme == ThemeMode.dark
                  ? MyTheme.whiteColor
                  : MyTheme.blackColor,
            ),
          ),
          content: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MyTheme.primaryColor),
          ),
          actions: [
            if (posActionName != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(key.currentContext!);
                  posAction?.call();
                },
                child: Text(
                  posActionName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.primaryColor),
                ),
              ),
            if (negActionName != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(key.currentContext!);
                  negAction?.call();
                },
                child: Text(
                  negActionName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.primaryColor),
                ),
              ),
          ],
        );
      },
    );
  }
// static void showMessage(
//     {required BuildContext context,
//     required String message,
//     required AppConfigProvider provider,
//     String title = '',
//     String? posActionName,
//     Function? posAction,
//     String? negActionName,
//     Function? negAction,
//     bool isDismissible = true}) {
//   List<Widget> actions = [];
//   if (posActionName != null) {
//     actions.add(TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//           posAction?.call();
//         },
//         child: Text(
//           posActionName,
//           style: Theme.of(context)
//               .textTheme
//               .titleSmall!
//               .copyWith(color: MyTheme.primaryColor),
//         )));
//   }
//   if (negActionName != null) {
//     actions.add(TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//           negAction?.call();
//         },
//         child: Text(
//           negActionName,
//           style: Theme.of(context)
//               .textTheme
//               .titleSmall!
//               .copyWith(color: MyTheme.primaryColor),
//         )));
//   }
//   showDialog(
//     barrierDismissible: isDismissible,
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: provider?.appTheme == ThemeMode.dark
//             ? MyTheme.blackDarkColor
//             : MyTheme.whiteColor,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: provider?.appTheme == ThemeMode.dark
//                 ? MyTheme.whiteColor
//                 : MyTheme.blackColor,
//           ),
//         ),
//         content: Text(
//           message,
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium!
//               .copyWith(color: MyTheme.primaryColor),
//         ),
//         actions: actions,
//       );
//     },
//   );
// }
}
