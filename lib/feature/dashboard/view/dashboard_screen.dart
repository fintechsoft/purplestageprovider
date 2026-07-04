import 'package:purplestage_provider/feature/dashboard/widgets/advertisement_section.dart';
import 'package:purplestage_provider/feature/nav/widgets/subscription_trail_end_widget.dart';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen>{
  final toolTip = JustTheController();

  @override
  void initState() {
    super.initState();
    Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
    Get.find<DashboardController>().getYearlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()));
    Get.find<BusinessSettingController>().getBookingSettingsDataFromServer();
    Get.find<BusinessSettingController>().getServiceAvailabilitySettingsFromServer();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<UserProfileController>(builder: (userProfileController){

      bool canShow = userProfileController.providerModel != null && userProfileController.providerModel!.content !=null && userProfileController.providerModel!.content!.subscriptionInfo !=null
          && userProfileController.providerModel!.content!.subscriptionInfo!.subscribedPackageDetails !=null && userProfileController.providerModel!.content!.subscriptionInfo!.subscribedPackageDetails!.trialDuration !=0
          && DateConverter.countDays(endDate: DateTime.parse(userProfileController.providerModel!.content!.subscriptionInfo!.subscribedPackageDetails!.packageEndDate!)) > 0;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar:  MainAppBar(
          color: Theme.of(context).primaryColor,
          title: AppConstants.appName,
          titleFontSize: Dimensions.fontSizeExtraLarge + 4,
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColorLight,
          backgroundColor: Theme.of(context).cardColor,
          onRefresh: () async {
            await Get.find<DashboardController>().getDashboardData();
            Get.find<DashboardController>().changeGraph(EarningType.monthly);
            Get.find<DashboardController>().changeRecentActivityView(status: true, shouldUpdate: true);
            Get.find<DashboardController>().changeTypeOfShowBookingStatus(status: true, shouldUpdate: true);
            await Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()),
                DateTime.now().month.toString());
            await Get.find<DashboardController>().getYearlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()));
            await Get.find<UserProfileController>().getProviderInfo(reload: true);
            Get.find<NotificationController>().getNotifications(1,saveNotificationCount: false);
            Get.find<SplashController>().getConfigData();
          },
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                TopCardSection(toolTip: toolTip,),
                const AdvertisementSection(),
                const GraphSection(),
                const RecentActivitySection(),
                const MySubscriptionSection(),
                const ServiceManSection(),
                const SizedBox(height: Dimensions.paddingSizeSmall)
              ],
            ),
          ),
        ),
        //floatingActionButton: Container(height: 20, color: Colors.red,),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: canShow && !userProfileController.trialWidgetNotShow ? const SubscriptionTrailEndWidget() : const SizedBox(),
      );
    });
  }
}
