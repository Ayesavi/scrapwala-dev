import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrapwala_dev/features/address/screens/select_address_page.dart';
import 'package:scrapwala_dev/features/auth/screens/get_started_page.dart';
import 'package:scrapwala_dev/features/auth/screens/login_page.dart';
import 'package:scrapwala_dev/features/auth/screens/verify_page.dart';
import 'package:scrapwala_dev/features/cart/cart_page.dart';
import 'package:scrapwala_dev/features/home/screens/home_page.dart';
import 'package:scrapwala_dev/features/profile/screens/profile_screen.dart';
import 'package:scrapwala_dev/features/search/screens/search_page.dart';
import 'package:scrapwala_dev/features/splash/screens/splash_screen.dart';

import './route_constants.dart';

part 'routes.g.dart';

@RouteConstants.splashRoute
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@RouteConstants.authRoute
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GetStartedPage();
}

@RouteConstants.homeRoute
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => HomePage();
}

class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginScreen();
}

class OtpPageRoute extends GoRouteData {
  const OtpPageRoute(this.phone);

  /// The phone number associated with the OTP page.
  final String phone;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OtpVerifyPage(phoneNum: phone);
}

class SearchPageRoute extends GoRouteData {
  const SearchPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => SearchPage();
}


class CartPageRoute extends GoRouteData {
  const CartPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CartPage();
}



class SelectAddressPageRoute extends GoRouteData {
  const SelectAddressPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SelectAddressPage();
}


class ProfilePageRoute extends GoRouteData {
  const ProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePage();
}
