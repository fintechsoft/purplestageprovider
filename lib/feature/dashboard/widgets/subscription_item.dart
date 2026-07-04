import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class SubscriptionCardItem extends StatelessWidget {
  final int index;
  final SubscriptionModelData subscriptionModelData;
  const SubscriptionCardItem({super.key, required this.subscriptionModelData, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.isDesktop(context)? Get.width*.2:ResponsiveHelper.isTab(context)?Get.width*.4:Get.width*.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow,
      ),
      margin:  const EdgeInsets.only(top: 4,bottom:4,left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeExtraSmall,),
      child: Stack(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [

            const SizedBox(width: 10),
            ClipRRect(borderRadius: BorderRadius.circular(5),
              child: CustomImage(height: 70, width: 70,
                image: '${subscriptionModelData.subCategory!=null?subscriptionModelData.subCategory!.imageFullPath:""}',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: Dimensions.paddingSizeSmall,),

            Expanded(
              child: SizedBox(

                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [


                    Text(subscriptionModelData.subCategory!=null?subscriptionModelData.subCategory!.name!:"",
                      style: ubuntuBold.copyWith( color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                    Text('${subscriptionModelData.servicesCount.toString()} ${'services'.tr}',
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                    Text('${subscriptionModelData.completedBookingCount.toString()} ${'bookings_completed'.tr}',
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                  ],
                ),
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall,),
          ],),

          Positioned.fill(child: CustomInkWell(onTap: (){
            Get.to(ServicesScreen(
              subscriptionModelData : subscriptionModelData,
              fromPage: 'dashboard',
              index: index,
            ));
          },))
        ],
      ),
    );
  }
}