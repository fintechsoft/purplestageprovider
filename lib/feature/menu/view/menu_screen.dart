import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    String aboutUs = Get.find<SplashController>().configModel.content!.aboutUs!;
    String privacyPolicy = Get.find<SplashController>().configModel.content!.privacyPolicy!;
    String termsAndCondition = Get.find<SplashController>().configModel.content!.termsAndConditions!;
    String refundPolicy = Get.find<SplashController>().configModel.content!.refundPolicy!;
    String cancellationPolicy = Get.find<SplashController>().configModel.content!.cancellationPolicy!;

    final List<MenuModel> menuList = [

      MenuModel(icon: Images.profileIcon, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      // MenuModel(icon: Images.mySubscriptions, title: 'mySubscription'.tr, route: RouteHelper.getMySubscriptionRoute()),
      MenuModel(icon: Images.chatImage, title: 'chat'.tr, routeValidation: "chat",route: RouteHelper.getInboxScreenRoute()),
      MenuModel(icon: Images.settings, title: 'settings'.tr, route: RouteHelper.getLanguageBottomSheet('menu')),
      MenuModel(icon: Images.notificationSetup, title: 'notification_channel'.tr, route: RouteHelper.getNotificationScreen()),
      MenuModel(icon: Images.transaction, title: 'withdraw_list'.tr, route: RouteHelper.transactions),
      MenuModel(icon: Images.reportOverview2, title: 'reports'.tr, routeValidation: "reports_&_analytics", route: RouteHelper.getReportingPageRoute('menu')),
      MenuModel(icon: Images.menuAdvertisement, title: 'advertisements'.tr, routeValidation: "advertisement", route: RouteHelper.getAdvertisementListScreen(
        count: Get.find<DashboardController>().additionalInfoCount?.advertisementCount ?? 0
      )),
      MenuModel(icon: Images.service, title: 'services'.tr, route: RouteHelper.getAllServicesRoute()),
      MenuModel(icon: Images.businessPlanIcon, title: 'business_plan'.tr, route: RouteHelper.getBusinessPlanScreen()),


      if(aboutUs!='') MenuModel(icon: Images.aboutUs, title: 'about_us'.tr, route: RouteHelper.getHtmlRoute(page:'about_us',fromPage: "about_us")),
      if(privacyPolicy!='') MenuModel(icon: Images.privacyPolicyIcon, title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute(page:'privacy-policy')),
      if(termsAndCondition!='')MenuModel(icon: Images.termsConditionIcon, title: 'terms_and_condition'.tr, route: RouteHelper.getHtmlRoute(page:'terms-and-condition')),
      if(refundPolicy!='')MenuModel(icon: Images.refund, title: 'refund_policy'.tr, route: RouteHelper.getHtmlRoute(page:'refund-policy')),
      if(cancellationPolicy!='')MenuModel(icon: Images.cancellation, title: 'cancellation_policy'.tr, route: RouteHelper.getHtmlRoute(page:'cancellation-policy')),
      MenuModel(icon: Images.logout, title: isLoggedIn ? 'log_out'.tr : 'sign_in'.tr, route: RouteHelper.getSignInRoute("menu"))

    ];


    return Container(
      width: Dimensions.webMaxWidth,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).cardColor,
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 7 : 4,
                mainAxisExtent: 120,
                crossAxisSpacing: Dimensions.paddingSizeExtraSmall
            ),
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              return MenuButton(menu: menuList[index], isLogout: index == menuList.length-1);
            },
          ),
          SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
          SafeArea(
            child: RichText(
              text: TextSpan(
                  text: "app_version".tr,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${AppConstants.appVersion} ",
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                    )
                  ]
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault)
        ]),
      ),
    );
  }
}
