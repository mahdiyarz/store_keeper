import 'package:flutter/material.dart';

import '../resources/strings_manager.dart';
import '../home/home.dart';
import '../login/login.dart';
import '../on_boarding/on_boarding.dart';
import '../register/register.dart';
import '../splash/splash.dart';
import '../store_details/store_details.dart';
import '../forgot_password/forgot_password.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/on-boarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String homeRoute = '/home';
  static const String storeDetailsRoute = '/store-details';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
