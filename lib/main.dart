// ignore_for_file: library_prefixes

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cnn_brasil_app/core/app/app_themes.dart';
import 'package:cnn_brasil_app/core/components/custom_error.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/core/mdm_notification_service.dart';
import 'package:cnn_brasil_app/core/providers/theme_provider.dart';
import 'package:cnn_brasil_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'flavors/development.dart' as DevConfig;
import 'flavors/production.dart' as ProdConfig;

FirebaseMessaging messaging = FirebaseMessaging.instance;

void setupFCM() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await MDMNotificationService.handleRemoteMessage(message);
}

Future<void> initTracking() async {
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;

  if (status == TrackingStatus.notDetermined) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }

  await AppTrackingTransparency.getAdvertisingIdentifier();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  OneSignal.initialize(AppConstants.ONESIGNAL_KEY);

  OneSignal.Notifications.requestPermission(true);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initTracking();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: CustomErrorWidget(
          errorDetails: details,
          onReload: () {
            runApp(const MyApp());
          },
        ),
      ),
    );
  };

  if (kReleaseMode) {
    AppManager.setBaseUrl(ProdConfig.FlavorConfig.apiUrl);
  } else {
    AppManager.setBaseUrl(DevConfig.FlavorConfig.apiUrl);
  }
  AppManager.setBaseUrl(ProdConfig.FlavorConfig.apiUrl);

  final themePreference = await StorageManager()
      .getString(AppConstants.SHARED_PREFERENCES_THEME_MODE);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FullscreenProvider()),
        ChangeNotifierProvider(create: (_) => TabbarProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(
            ThemeMode.values.firstWhere(
              (mode) => mode.toString() == themePreference,
              orElse: () {
                StorageManager().setString(
                    AppConstants.SHARED_PREFERENCES_THEME_MODE,
                    ThemeMode.light.toString());

                return ThemeMode.light;
              },
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.white.withOpacity(0.6),
      overlayHeight: 80,
      overlayWidth: 80,
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          ),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cnn Brasil',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        onGenerateRoute: AppRouters.generateRoute,
      ),
    );
  }
}
