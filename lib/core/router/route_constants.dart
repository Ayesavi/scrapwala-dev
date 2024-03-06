import 'package:go_router/go_router.dart';
import 'package:scrapwala_dev/core/router/routes.dart';

class RouteConstants {
  static const splashRoute =
      TypedGoRoute<SplashRoute>(path: '/', name: 'splash');

  static const homeRoute =
      TypedGoRoute<HomeRoute>(path: '/home', name: 'home', routes: [
    TypedGoRoute<SearchPageRoute>(path: 'search', name: "search"),
    TypedGoRoute<CartPageRoute>(path: 'cartPage', name: "cartPage"),
    TypedGoRoute<ProfilePageRoute>(path: 'profilePage', name: "profilePage"),
    TypedGoRoute<SelectAddressPageRoute>(
        path: 'selectAddressPage', name: "selectAddressPage"),
  ]);

  static const authRoute =
      TypedGoRoute<AuthRoute>(path: '/auth', name: 'auth', routes: [
    TypedGoRoute<LoginRoute>(path: 'login', name: "login"),
    TypedGoRoute<OtpPageRoute>(path: 'otp/:phone', name: 'otp')
  ]);
}
