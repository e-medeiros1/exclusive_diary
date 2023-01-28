import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/login/email/controller/login_with_email_controller.dart';
import '../../pages/login/google/controller/login_with_google_controller.dart';

enum Options { night, exit }

class CustomAppBar extends GetxController {
  final LoginWithGoogleController googleInstance =
      Get.find<LoginWithGoogleController>();
  final LoginWithEmailController emailInstance =
      Get.find<LoginWithEmailController>();
  final AppStyle appStyleInstance = Get.put(AppStyle());
  var appBarHeight = AppBar().preferredSize.height;

  buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Exclusive Diary',
          style: AppStyle.mainText
              .copyWith(fontFamily: 'DancingScript-Regular', fontSize: 32)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppStyle.backgroundColor,
      iconTheme: AppStyle.themeAppBar.iconTheme,
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            _onMenuItemSelected(value as int, context);
            Get.offAllNamed('/login');
          },
          icon:
              const Icon(Icons.settings_outlined, color: AppStyle.primaryColor),
          color: AppStyle.secondaryColor,
          offset: Offset(0.0, appBarHeight),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          itemBuilder: (ctx) => [
            _buildPopupMenuItem(
                'Sair', Icons.logout_outlined, Options.exit.index),
          ],
        )
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: AppStyle.primaryColor,
            size: 21,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: AppStyle.regularText,
          ),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value, context) {
    if (value == Options.exit.index) {
      googleInstance.signOut(context: context);
      emailInstance.signOut(context: context);
    }
  }
}
