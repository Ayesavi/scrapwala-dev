import 'package:go_router/go_router.dart';
import 'package:scrapwala_dev/core/router/routes.dart';

class RouteConstants {
  static const splashRoute =
      TypedGoRoute<SplashRoute>(path: '/', name: 'splash');

  static const homeRoute =
      TypedGoRoute<HomeRoute>(path: '/home', name: 'home', routes: [
    TypedGoRoute<SearchPageRoute>(path: 'search', name: "search"),
    TypedGoRoute<CartPageRoute>(path: 'cartPage', name: "cartPage"),
    profileRoute,
    TypedGoRoute<DeletePageRoute>(path: 'deleteUser', name: "deleteUser"),
    TypedGoRoute<RequestInfoPageRoute>(
        path: 'requestInfoPage/:requestId', name: "requestInfoPage"),
  ]);

  static const appRequiresUpdate = TypedGoRoute<ForceUpdatePageRoute>(
      path: '/appRequiresUpdate', name: 'appRequiresUpdate');

  static const maintenancePage = TypedGoRoute<MaintenancePageRoute>(
      path: '/maintenance', name: 'maintenance');
  static const authRoute =
      TypedGoRoute<AuthRoute>(path: '/auth', name: 'auth', routes: [
    TypedGoRoute<LoginRoute>(path: 'login', name: "login"),
    TypedGoRoute<OtpPageRoute>(path: 'otp/:phone', name: 'otp')
  ]);

  static const editProfileRoute = TypedGoRoute<EditProfileBaseRoute>(
      path: '/editProfile', name: "editProfile");

  static const profileRoute =
      TypedGoRoute<ProfilePageRoute>(path: 'profile', name: "profile", routes: [
    TypedGoRoute<EditProfileRoute>(
        path: 'editProfilePage', name: "editProfilePage"),
    TypedGoRoute<PastRequestsRoute>(
        path: 'pastRequestsPage', name: "pastRequestsPage"),
    TypedGoRoute<AddressPageRoute>(
        path: 'addressesPage', name: "addressesPage"),
  ]);
}
