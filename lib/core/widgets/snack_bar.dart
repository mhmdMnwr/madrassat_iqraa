import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MySnackBars {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: AwesomeSnackbarContent(
            title: 'نجاح', message: message, contentType: ContentType.success),
      ),
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> failure({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: AwesomeSnackbarContent(
          title: 'فشل',
          message: message,
          contentType: ContentType.failure,
        ),
      ),
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loading({
    required String message,
    required BuildContext context,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: AwesomeSnackbarContent(
          title: 'تحميل',
          message: message,
          contentType: ContentType.help,
        ),
      ),
    ));
  }

  /// failure
  // static var failureSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'On Snap!',
  //     message:
  //         'You have failed to read this failure message.\nPlease try again!',
  //     contentType: ContentType.failure,
  //   ),
  // );

  // /// help
  // static var helpSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Hi There!',
  //     message:
  //         'You need to use this package in the app to uplift your Snackbar Experinece!',
  //     contentType: ContentType.help,
  //   ),
  // );

  // /// success
  // static var successSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Congratulation!',
  //     message:
  //         'You have successfulyy read this message.\nPlease continue working!',
  //     contentType: ContentType.success,
  //   ),
  // );

  // /// warning
  // static var warningSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Warning!',
  //     message: 'You Have a warning for this message.\nPlease read carefully!',
  //     contentType: ContentType.warning,
  //   ),
  // );
}
