import 'package:purplestage_provider/helper/help_me.dart';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color color;
  final bool fromBookingRequest;
  final  double? titleFontSize;
  const MainAppBar({
    super.key,
    this.title,
    required this.color, this.fromBookingRequest = false, this.titleFontSize,
  });

  @override
  Widget build(BuildContext context) {

    return GetBuilder<NotificationController>(builder: (notificationController){
      return GetBuilder<SplashController>(builder: (splashController){
        return AppBar(
          elevation: 5,
          titleSpacing: -5,
          surfaceTintColor: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).cardColor,
          shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall + 3, vertical: Dimensions.paddingSizeExtraSmall ),
            child: Image.asset(Images.appbarLogo, fit: BoxFit.fitWidth,),
          ),
          title: title!=null?
          Text(title!.tr,
            style: ubuntuBold.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: titleFontSize ?? Dimensions.fontSizeExtraLarge,
            ),
          ):Image.asset(Images.logo, width: 110,),
          actions: [

            (fromBookingRequest && Get.find<SplashController>().configModel.content?.biddingStatus==1)?
            GestureDetector(
              onTap: () => Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet().then((isTrial){
                if(isTrial){
                  if(Get.find<UserProfileController>().checkAvailableFeatureInSubscriptionPlan(featureType: 'bidding')){
                    Get.to(()=> const CustomerRequestListScreen());
                  }
                }
              }),

              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Image.asset(
                  splashController.showRedDotIconForCustomBooking ?
                  Images.createPostIconWithRedDot :  Images.createPostIconWithoutDot,
                  height: 35,width: 35,
                ),
              ),
            ) :
            Padding(padding: const EdgeInsets.only(top: 10.0), child: Stack(children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.getNotificationRoute());
                    if(isRedundentClick(DateTime.now())){
                      return;
                    }
                    notificationController.resetNotificationCount();
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                  )
              ),
              if( notificationController.unseenNotificationCount>0)Positioned(
                right: 2,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor
                  ),
                  child: FittedBox(
                      child: Text(
                        notificationController.unseenNotificationCount.toString(),
                        style: ubuntuRegular.copyWith(color: light.cardColor
                        ),
                      )
                  ),
                ),
              )
            ])),
            const SizedBox(
              width: Dimensions.paddingSizeExtraSmall,
            )
          ],
        );
      });
    });
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}

