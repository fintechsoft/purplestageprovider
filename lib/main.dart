
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';
import 'feature/nav/widgets/cash_overflow_dialog.dart';
import 'helper/get_di.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

AndroidNotificationChannel? channel1;
AndroidNotificationChannel? channel2;

Future<void> main() async {
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Guard against duplicate DEFAULT Firebase initialization
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // If already initialized natively by any package, reuse safely
    Firebase.app();
  }

  if (GetPlatform.isAndroid && !Firebase.apps.any((a) => a.name == "[DEFAULT]")) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBwHjFDDr5Nqh8CDjyDIgbLbxvnj4Gnr0E",
        appId: "1:229824148445:web:a81d0cd40eb88de23bfc34",
        messagingSenderId: "229824148445",
        projectId: "provider-app-1a3c2",
      ),
    );
  }


  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FlutterDownloader.initialize(debug: false, ignoreSsl: false);

  if (defaultTargetPlatform == TargetPlatform.android) {
    await FirebaseMessaging.instance.requestPermission();
  }

  Map<String, Map<String, String>> languages = await init();
  NotificationBody? body;

  try {
    if (GetPlatform.isMobile) {
      final remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        body = NotificationHelper.convertNotification(remoteMessage.data);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (_) {}
  if (GetPlatform.isAndroid) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  runApp(MyApp(languages: languages, body: body));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  final NotificationBody? body;
  const MyApp({super.key, required this.languages, required this.body});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: themeController.darkTheme ? dark : light,
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          initialRoute: RouteHelper.getSplashRoute(body: body,),
          getPages: RouteHelper.routes,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 300),
          builder: (context, widget) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
            child: Material(
              child: Stack(children: [
                widget!,
                GetBuilder<UserProfileController>(builder: (userProfileController){

                  double receivableAmount = double.tryParse(userProfileController.providerModel?.content?.providerInfo?.owner?.account?.accountReceivable ?? "0" ) ?? 0;
                  double payableAmount = double.tryParse(userProfileController.providerModel?.content?.providerInfo?.owner?.account?.accountPayable ?? "0") ?? 0 ;

                  TransactionType transactionType =  userProfileController.getTransactionType(payableAmount, receivableAmount);
                  double transactionAmount =  userProfileController.getTransactionAmountAmount(payableAmount, receivableAmount);

                  double payablePercent =  userProfileController.providerModel != null ?
                  userProfileController.getOverflowPercent(payableAmount, receivableAmount, Get.find<SplashController>().configModel.content?.maxCashInHandLimit?? 0) : 0;

                  bool overFlowDialogStatus = userProfileController.showOverflowDialog && userProfileController.providerModel != null &&
                      Get.find<SplashController>().configModel.content?.suspendOnCashInHandLimit == 1 &&  Get.find<SplashController>().configModel.content?.digitalPayment == 1;

                  return  SafeArea(
                    child: Align(alignment: Alignment.bottomRight,
                      child: Padding(padding: const EdgeInsets.only(bottom: 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            (transactionType == TransactionType.payable || transactionType == TransactionType.adjustAndPayable ||  transactionType == TransactionType.adjust)
                                && ( payablePercent >= 80  && overFlowDialogStatus) && !userProfileController.trialWidgetNotShow
                                ?  CashOverflowDialog(payablePercent: payablePercent,amount: transactionAmount,) : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ]),
            ),
          ),
        );
      },
      );
    },
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}