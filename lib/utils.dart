import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/firebase_options.dart';
import 'package:food_couriers_admin/services/auth_service.dart';
import 'package:food_couriers_admin/services/database_service.dart';
import 'package:food_couriers_admin/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}

DeviceScreenType? deviceType;
double? screenWidth;
double? screenHeight;

TextStyle commonTextStyle(double fontSize, FontWeight fontWeight) {
  return TextStyle(
    fontFamily: 'DM Sans',
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: 1.1,
    letterSpacing: -0.03 * fontSize,
    color: AppColors.textDarkColor,
  );
}

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      borderSide: BorderSide(
        color: AppColors.primary.withAlpha(200),
      ),
    );
  }

String formatDate(DateTime dateTime) {
  return DateFormat('EEEE, MMMM d, y h:mm a').format(dateTime);
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);


// String generateChatID({required String uid1, required String uid2}) {
//   List uids = [uid1, uid2];
//   uids.sort();
//   String chatID = uids.fold("", (id, uid) => "$id$uid");
//   return chatID;
// }

