

import 'package:flutter/material.dart';
import 'package:task_management_app/features/auth/pages/login_page.dart';
import 'package:task_management_app/features/auth/pages/otp_page.dart';
import 'package:task_management_app/features/onboarding/pages/onboarding.dart';
import 'package:task_management_app/features/todo/pages/homepage.dart';

class Routes {
  static const String unboarding = 'unboarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case unboarding:
        return MaterialPageRoute(builder: (context) => const UnBoarding());

      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(builder: (context) => 
        OtpPage(
          phone: args['phone'], 
          smsCodeId: args['smsCodeId'],));

          case home:
        return MaterialPageRoute(builder: (context) => const HomePage());

        
      default:
      return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
