import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'constant.dart';
import 'flutter/flutter_theme.dart';
import 'flutter/flutter_util.dart';
import 'flutter/internationalization.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'flutter/nav/nav.dart';
import 'index.dart';
import 'notificationservice/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
  // ToastMessage.msg(message.notification!.title.toString());
  // ToastMessage.msg(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  usePathUrlStrategy();

  await FirebaseAppCheck.instance.activate (

    // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // androidProvider: AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.enableIOSNotifications();
  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
      // ToastMessage.msg(message.notification!.title.toString());
      // ToastMessage.msg(message.data.toString());
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data22 ${message.data['_id']}");
      }
      LocalNotificationService.enableIOSNotifications();
    },
  );
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    print("FirebaseMessaging.instance.getInitialMessage");
    if (message != null) {
      print("New Notification");
      // if (message.data['_id'] != null) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => NotificationPage( serviceId: message.data['_id'],
      //       ),
      //     ),
      //   );
      // }
    }
  },);
  FirebaseMessaging.onMessage.listen(
        (message) {
      if (kDebugMode) {
        print("FirebaseMessaging.onMessage.listen");

        print("=============message.notification!.title.toString()==========${message.notification!.title.toString()}");



        ToastMessage.msg(message.notification!.body.toString());



        // ToastMessage.msg(message.data.toString());
      }
      if (message.notification != null) {
        if (kDebugMode) {
          print(message.notification!.title);
        }
        if (kDebugMode) {
          print(message.notification!.body);
        }
        if (kDebugMode) {
          print("message.data11 ${message.data}");
        }
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );


  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      // ToastMessage.msg(message.notification!.title.toString());
      // ToastMessage.msg(message.data.toString());
      if (message.notification != null) {
        print(message.notification!.title);
        print("Testing : "+ message.notification!.body.toString());
        print("message.data22 ${message.data['_id']}");
      }
      LocalNotificationService.enableIOSNotifications();
    },
  );
  usePathUrlStrategy();
  await initFirebase();

  await FlutterTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterTheme.themeMode;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = carRentalFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 10),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CarRental',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('es'),
        Locale('pt'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'your_currentBooking_page': YourCurrentBookingPageWidget(),
      'your_favouriteList_page': YourFavouriteListPageWidget(),
      'settings_page': SettingsPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: Visibility(
        visible: responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ),
        child: FloatingNavbar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
           backgroundColor: Colors.transparent,
          // selectedItemColor: FlutterTheme.of(context).accent2,
          // unselectedItemColor: FlutterTheme.of(context).accent2,
            selectedBackgroundColor: Colors.transparent,
          borderRadius: 8.0,
          itemBorderRadius: 8.0,
          margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
          width: double.infinity,
          elevation: 1.0,
          items: [
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.home_outlined,
                  //   color: currentIndex == 0
                  //       ? FlutterTheme.of(context).primaryBtnText
                  //       : FlutterTheme.of(context).accent2,
                  //   size: 24.0,
                  // ),
                  SvgPicture.asset(
                    currentIndex == 0
                        ? 'assets/images/home_unfill.svg'
                        : 'assets/images/graphics_outline.svg',
                    width: 30.33,
                    height: 20.5,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      '4rn1ny7d' /* Home */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 0
                          ? Color(0xff553FA5)
                          : Color(0xff7C8BA0),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.directions_car,
                  //   color: currentIndex == 1
                  //       ? FlutterTheme.of(context).primaryBtnText
                  //       : FlutterTheme.of(context).accent2,
                  //   size: 24.0,
                  // ),
                  SvgPicture.asset(
                    currentIndex == 1
                        ? 'assets/images/car_unfill.svg'
                        : 'assets/images/car_outline.svg',
                    width: 30.33,
                    height: 20.5,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'icu4qvrc' /* Bookings */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 1
                          ? Color(0xff553FA5)
                          : Color(0xff7C8BA0),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.favorite,
                  //   color: currentIndex == 2
                  //       ? FlutterTheme.of(context).primaryBtnText
                  //       : FlutterTheme.of(context).accent2,
                  //   size: 24.0,
                  // ),
                  SvgPicture.asset(
                    currentIndex == 2
                        ? 'assets/images/favorite_unfill.svg'
                        : 'assets/images/bookmark_outline-03.svg',
                    width: 30.33,
                    height: 20.5,
                  ),
                  Text(
                    FFLocalizations.of(context).getText('add_list'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 2
                          ? Color(0xff553FA5)
                          : Color(0xff7C8BA0),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.settings,
                  //   color: currentIndex == 3
                  //       ? FlutterTheme.of(context).primaryBtnText
                  //       : FlutterTheme.of(context).accent2,
                  //   size: 24.0,
                  // ),
                  SvgPicture.asset(
                    currentIndex == 3
                        ? 'assets/images/setting_unfill-2.svg'
                        : 'assets/images/setting_outline-2.svg',
                    width: 30.33,
                    height: 20.5,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      '39k73xfz' /* Settings */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 3
                          ? Color(0xff553FA5)
                          : Color(0xff7C8BA0),
                          // : FlutterTheme.of(context).primaryBtnText,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
