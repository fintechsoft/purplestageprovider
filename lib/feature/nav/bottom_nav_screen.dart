
import 'package:purplestage_provider/feature/event/view/event_list_screen.dart';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';


class BottomNavScreen extends StatefulWidget {
  final int pageIndex;
  const BottomNavScreen({super.key, required this.pageIndex});

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;
  bool _canExit = GetPlatform.isWeb ? true : false;
  @override
  void initState() {
    super.initState();
    _loadData();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });

  }

  _loadData() async {
    Get.find<LocalizationController>().filterLanguage(shouldUpdate: false);
    Get.find<DashboardController>().getDashboardData(reload: true);
    Get.find<ConversationController>().getChannelList(1, type: "serviceman");
    Get.find<ConversationController>().getChannelList(1, type: "customer");
    Get.find<ServicemanSetupController>().getAllServicemanList(1,reload: true, status: 'all');
    await Get.find<UserProfileController>().getProviderInfo(reload: true).then((isProviderModelAvailable){
      Get.find<BusinessSubscriptionController>().getSubscriptionPackageList();
      if(widget.pageIndex != 1){
        Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet();
      }
      Get.find<UserProfileController>().trialWidgetShow(route: "");
    });
    Get.find<AuthController>().updateToken();
  }

  @override
  Widget build(BuildContext context) {

    _screens = [
      const DashBoardScreen(),
      const BookingRequestScreen(),
     // const AllServicesScreen(),
      const EventListScreen(),
      Text("more".tr),
    ];


    return CustomPopScopeWidget(
      onPopInvoked: (){
        if (_pageIndex != 0) {
          _setPage(0);
        } else {
          if(_canExit) {
            exit(0);
          }else {
            showCustomSnackBar('back_press_again_to_exit'.tr,  type: ToasterMessageType.info);
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
          }
        }
      },
      child: GetBuilder<SplashController>(builder: (splashController){
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 70, alignment: Alignment.center,
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                  color: Get.isDarkMode?Theme.of(context).colorScheme.surface:Theme.of(context).primaryColor,
                  boxShadow:[
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    )]
              ),
              child: Row(children: [
                _getBottomNavItem(0, Images.dashboard, 'dashboard'.tr),
                _getBottomNavItem(1, Images.requests, 'requests'.tr),
                _getBottomNavItem(2, Images.adsType, 'events'.tr),
                _getBottomNavItem(3, Images.more, 'more'.tr),
              ]),
            ),
          ),
          body: GetBuilder<UserProfileController>(
            builder: (userProfileController) {
              return PageView.builder(
                controller: _pageController,
                itemCount: _screens!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _screens![index];
                },
              );
            }
          ),
          floatingActionButton: Get.find<SplashController>().configModel.content?.biddingStatus==1 && Get.find<SplashController>().showCustomBookingButton?   GestureDetector(
            onTap: () => Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet().then((isTrial){
              if(isTrial){
                if(Get.find<UserProfileController>().checkAvailableFeatureInSubscriptionPlan(featureType: 'bidding')){
                  Get.to(()=> const CustomerRequestListScreen());
                }
              }
            }),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: shadow,
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault-2),
              child: Image.asset(Images.createPostIconWithRedDot,height: 40,width: 40,

              ),
            ),
          ): null,
        );
      }),
    );
  }

  void _setPage(int pageIndex) {
    if(pageIndex == 3) {
      Get.find<UserProfileController>().trialWidgetShow(route: "show-dialog");
      Get.bottomSheet(
        const MenuScreen(),
        backgroundColor: Colors.transparent, isScrollControlled: true,
        barrierColor: Colors.black.withOpacity(Get.isDarkMode ? 0.7 : 0.6 ),
      ).then((_){
        Get.find<UserProfileController>().trialWidgetShow(route: "");
      });
    }else {
      setState(() {
        _pageController?.jumpToPage(pageIndex);
        _pageIndex = pageIndex;

      });
    }
  }

  Widget _getBottomNavItem(int index, String icon, String title) {
    return Expanded(child: InkWell(
      onTap: () => _setPage(index),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        icon.isEmpty ? const SizedBox(width: 20, height: 20) : Image.asset(
          icon, width: 17, height: 17,
          color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Text(title, style: ubuntuRegular.copyWith(
          fontSize: Dimensions.fontSizeSmall,
          color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        )),

      ]),
    ));
  }

}
