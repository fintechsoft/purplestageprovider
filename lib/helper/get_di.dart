import 'dart:convert';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';


Future<Map<String, Map<String, String>>> init() async{

  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));


  /// Repository
  Get.lazyPut(() => PostRepo(apiClient: Get.find()));
  Get.lazyPut(() => ConversationRepo(apiClient: Get.find()));
  Get.lazyPut(() => SuggestServiceRepo(apiClient: Get.find()));
  Get.lazyPut(() => ReviewRepo(apiClient: Get.find()));
  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => DashBoardRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => ServicemanRepo(apiClient: Get.find()));
  Get.lazyPut(() => BookingDetailsRepo(apiClient: Get.find()));
  Get.lazyPut(() => ReportRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => BookingRequestRepo(apiClient: Get.find()));
  Get.lazyPut(() => AdvertisementRepo(apiClient: Get.find()));
  Get.lazyPut(() => EventRepo(apiClient: Get.find()));
  Get.lazyPut(() => SubscriptionRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BusinessSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => NotificationSetupRepo(apiClient: Get.find()));
  Get.lazyPut(() => TransactionRepo(apiClient: Get.find()));
  Get.lazyPut(() => HtmlRepository(apiClient: Get.find()));
  Get.lazyPut(() => BankInfoRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ServiceDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  /// Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ReviewController(reviewRepo: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PostController(postRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => UserProfileController( userRepo: Get.find()));
  Get.lazyPut(() => DashboardController(dashBoardRepo: Get.find()));
  Get.lazyPut(() => BookingReportController(reportRepo: Get.find()));
  Get.lazyPut(() => BusinessReportController(reportRepo: Get.find()));
  Get.lazyPut(() => ServiceCategoryController(serviceRepo:ServiceRepo(apiClient: Get.find())));
  Get.lazyPut(() => TransactionController(transactionRepo: Get.find()));
  Get.lazyPut(() => TransactionReportController(reportRepo: Get.find()));
  Get.lazyPut(() => BookingDetailsController(bookingDetailsRepo: Get.find()));
  Get.lazyPut(() => BookingRequestController(bookingRequestRepo: Get.find()));
  Get.lazyPut(() => AdvertisementController(advertisementRepo: Get.find()));
  Get.lazyPut(() => EventController(eventRepo: Get.find()));
  Get.lazyPut(() => ServicemanDetailsController(servicemanRepo: Get.find()));
  Get.lazyPut(() => ConversationController(conversationRepo: Get.find()));
  Get.lazyPut(() => SuggestServiceController(suggestServiceRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => BusinessSubscriptionController(subscriptionRepo: Get.find()));
  Get.lazyPut(() => BusinessSettingController(businessSettingRepo: Get.find()));
  Get.lazyPut(() => NotificationSetupController(notificationSetupRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => BookingEditController(serviceRepo: ServiceRepo(apiClient: Get.find()), bookingDetailsRepo: Get.find()));
  Get.lazyPut(() => SubcategorySubscriptionController(subscriptionRepo: Get.find()));
  Get.lazyPut(() => HtmlViewController(htmlRepository: Get.find()));
  Get.lazyPut(() => BankInfoController(bankInfoRepo: Get.find()));
  Get.lazyPut(() => ServicemanSetupController(servicemanRepo: Get.find()));
  Get.lazyPut(() => ServiceDetailsController(serviceDetailsRepo: Get.find()));


  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsonValue = {};
    mappedJson.forEach((key, value) {
      jsonValue[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = jsonValue;
  }
  return languages;
}
