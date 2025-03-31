import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../splash_screen.dart';
import '/auth/base_auth_user_provider.dart';
import '/index.dart';
import '/main.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/lat_lng.dart';
import '/flutter/place.dart';
import '/flutter/flutter_util.dart';
import 'serialization_util.dart';
export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : IntroPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>SpashScreen(),
          // builder: (context, _) =>
          //     appStateNotifier.loggedIn ? NavBarPage() : IntroPageWidget(),
          routes: [
            FFRoute(
              name: 'SplashPage1',
              path: 'splashPage1',
              builder: (context, params) => SplashPage1Widget(),
            ),
            FFRoute(
              name: 'LoginPage',
              path: 'loginPage',
              builder: (context, params) => LoginPageWidget(),
            ),
            FFRoute(
              name: 'NotificationPage',
              path: 'notificationPage',
              builder: (context, params) => NotificationPageWidget(),
            ),
            FFRoute(
              name: 'signupPage',
              path: 'signupPage',
              builder: (context, params) => SignupPageWidget(),
            ),
            FFRoute(
              name: 'HomePage',
              path: 'homePage',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'HomePage')
                  : NavBarPage(
                      initialPage: 'HomePage',
                      page: HomePageWidget(),
                    ),
            ),
            FFRoute(
              name: 'vehicle_listing_page',
              path: 'vehicleListingPage',
              builder: (context, params) => VehicleListingPageWidget(lat: null, long: null, lat2: null, long2: null, lat3: null, long3: null, car_id: '',),
            ),
            FFRoute(
              name: 'more_filter_page',
              path: 'moreFilterPage',
              builder: (context, params) => MoreFilterPageWidget(),
            ),
            FFRoute(
              name: 'product_detail_page',
              path: 'productDetailPage',
              builder: (context, params) => ProductDetailPageWidget(
                carId: params.getParam('carId', ParamType.String),
                time: params.getParam('time', ParamType.String),
                distance: params.getParam('distance', ParamType.double),
              ),
            ),
            FFRoute(
              name: 'your_currentBooking_page',
              path: 'yourCurrentBookingPage',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'your_currentBooking_page')
                  : YourCurrentBookingPageWidget(),
            ),
            FFRoute(
              name: 'address_page',
              path: 'addressPage',
              builder: (context, params) => AddressPageWidget(),
            ),
            FFRoute(
              name: 'payment_method_page',
              path: 'paymentMethodPage',
              builder: (context, params) => PaymentMethodPageWidget(),
            ),
            FFRoute(
              name: 'Information_page',
              path: 'informationPage',
              builder: (context, params) => InformationPageWidget(),
            ),
            FFRoute(
              name: 'message_page',
              path: 'messagePage',
              builder: (context, params) => MessagePageWidget(),
            ),
            FFRoute(
              name: 'location_page',
              path: 'locationPage',
              builder: (context, params) => LocationPageWidget(),
            ),
            FFRoute(
              name: 'booking_page',
              path: 'bookingPage',
              builder: (context, params) => BookingPageWidget(
                carDetailBooking:
                    params.getParam('carDetailBooking', ParamType.JSON),
                priceType: params.getParam('priceType', ParamType.String),
                carCost: params.getParam('carCost', ParamType.double),
                supplierid: params.getParam('supplierid', ParamType.String),
                carid: params.getParam('carId', ParamType.String), ownername: '', car_type: '',
              ),
            ),
            FFRoute(
              name: 'edit_profile',
              path: 'editProfile',
              builder: (context, params) => EditProfileWidget(),
            ),
            FFRoute(
              name: 'confirmation_page',
              path: 'confirmationPage',
              builder: (context, params) => ConfirmationPageWidget(
                bookingDetails:
                    params.getParam('bookingDetails', ParamType.JSON),
                driverType: params.getParam('driverType', ParamType.String),
                daysAndHourlyType:
                    params.getParam('daysAndHourlyType', ParamType.bool),
                pickupLocation:
                    params.getParam('pickupLocation', ParamType.String),
                dropoffLocation:
                    params.getParam('dropoffLocation', ParamType.String),
                userName: params.getParam('userName', ParamType.String),
                contactnumber:
                    params.getParam('contactnumber', ParamType.String),
                pickupDate: params.getParam('pickupDate', ParamType.String),
                dropoffDate: params.getParam('dropoffDate', ParamType.String),
                licenceForntImage: params.getParam(
                    'licenceForntImage', ParamType.FFUploadedFile),
                licenceBackImage: params.getParam(
                    'licenceBackImage', ParamType.FFUploadedFile),
                totalAmount: params.getParam('totalAmount', ParamType.String),
                totalDays: params.getParam('totalDays', ParamType.int),
                hoursAndMin: params.getParam('hoursAndMin', ParamType.double),
                supplierid: params.getParam('supplierid', ParamType.String), coupon_code:  params.getParam('coupon_code', ParamType.String),

              ),
            ),
            FFRoute(
              name: 'booking_successfully_page',
              path: 'bookingSuccessfullyPage',
              builder: (context, params) => BookingSuccessfullyPageWidget(
                carName: params.getParam('carName', ParamType.String),
                pickLocation: params.getParam('pickLocation', ParamType.String),
                dropoffLocation:
                params.getParam('dropoffLocation', ParamType.String),
                pickupdate: params.getParam('pickupdate', ParamType.String),
                dropoffDate: params.getParam('dropoffDate', ParamType.String),
                parDayRent: params.getParam('parDayRent', ParamType.String),
                totalAmount: params.getParam('totalAmount', ParamType.String),
                car_type: params.getParam('car_type', ParamType.String),
                coupon_code: params.getParam('coupon_code', ParamType.String),
                ownername: params.getParam('ownername', ParamType.String),
                username: params.getParam('username', ParamType.String),
                totalFees: params.getParam('totalFees', ParamType.String),
                responseData: params.getParam('responseData', ParamType.JSON),
              ),
            ),
            FFRoute(
              name: 'add_my_payment_page',
              path: 'addMyPaymentPage',
              builder: (context, params) => AddMyPaymentPageWidget(),
            ),
            FFRoute(
              name: 'support_page',
              path: 'supportPage',
              builder: (context, params) => SupportPageWidget(),
            ),
            FFRoute(
              name: 'booking_History_List',
              path: 'bookingHistoryList',
              builder: (context, params) => BookingHistoryListWidget(),
            ),
            FFRoute(
              name: 'booking_detail_page',
              path: 'bookingDetailPage',
              builder: (context, params) => BookingDetailPageWidget(
                bookingId: params.getParam('bookingId', ParamType.double),
              ),
            ),
            FFRoute(
              name: 'change_password_page',
              path: 'changePasswordPage',
              builder: (context, params) => ChangePasswordPageWidget(),
            ),
            FFRoute(
              name: 'your_favouriteList_page',
              path: 'yourFavouriteListPage',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'your_favouriteList_page')
                  : YourFavouriteListPageWidget(),
            ),
            FFRoute(
              name: 'histroy_detail_page',
              path: 'histroyDetailPage',
              builder: (context, params) => HistroyDetailPageWidget(
                bookingId: params.getParam('bookingId', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'settings_page',
              path: 'settingsPage',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'settings_page')
                  : NavBarPage(
                      initialPage: 'settings_page',
                      page: SettingsPageWidget(),
                    ),
            ),
            FFRoute(
              name: 'search_page',
              path: 'searchPage',
              builder: (context, params) => SearchPageWidget(
                vihecalList: params.getParam<dynamic>(
                    'vihecalList', ParamType.JSON, true),
              ),
            ),
            FFRoute(
              name: 'language_page',
              path: 'languagePage',
              builder: (context, params) => LanguagePageWidget(),
            ),
            FFRoute(
              name: 'intro_page',
              path: 'introPage',
              builder: (context, params) => IntroPageWidget(),
            ),
            FFRoute(
              name: 'welcome_page',
              path: 'welcomePage',
              builder: (context, params) => WelcomePageWidget(),
            ),
            FFRoute(
              name: 'mobileNumberlogin_Page',
              path: 'mobileNumberloginPage',
              builder: (context, params) => MobileNumberloginPageWidget(),
            ),
            FFRoute(
              name: 'verificationcode_page',
              path: 'verificationcodePage',
              builder: (context, params) => VerificationcodePageWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/introPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ?      FutureBuilder(
          future: ffParams.completeFutures(),
          builder: (context, _) => builder(context, ffParams),
          )
              : builder(context, ffParams);
          final child = page;
          // FutureBuilder(
          //         future: ffParams.completeFutures(),
          //         builder: (context, _) => builder(context, ffParams),
          //       )
          //     : builder(context, ffParams);
          // final child = appStateNotifier.loading
          //     ? Container(
          //         color: FlutterTheme.of(context).secondary,
          //         child: Center(
          //           child: Image.asset(
          //             'assets/images/01_Splash@3x.png',
          //             width: double.infinity,
          //             height: double.infinity,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       )
          //     : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
