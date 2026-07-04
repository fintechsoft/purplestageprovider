import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class RecentActivityCardItem extends StatelessWidget {
  final DashboardRecentActivityModel dashboardRecentActivityModel;
  const RecentActivityCardItem({
    super.key,
    required this.dashboardRecentActivityModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all( Dimensions.paddingSizeSmall),
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),

      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: CustomImage(height: 60, width: 60, fit: BoxFit.cover,
              image: "${dashboardRecentActivityModel.detail![0].service!=null?dashboardRecentActivityModel.detail![0].service!.thumbnailFullPath:""}",
            )
          ),

          const SizedBox(width: Dimensions.paddingSizeDefault,),
          Expanded(
            child: SizedBox(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  Text("${'booking'.tr}#  ${dashboardRecentActivityModel.readableId}",
                    style: ubuntuBold.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
                    )
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(DateConverter.dateMonthYearTime(DateConverter
                      .isoUtcStringToLocalDate(dashboardRecentActivityModel.createdAt!)),
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),),
                      textDirection: TextDirection.ltr
                  )
                ]
              )
            )
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.fontSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:Get.isDarkMode?Colors.grey.withOpacity(0.2):
              ColorResources.buttonBackgroundColorMap[dashboardRecentActivityModel.bookingStatus],
            ),
            child: Text(
              dashboardRecentActivityModel.bookingStatus!.tr,
              style:ubuntuMedium.copyWith(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeSmall,
                  color:Get.isDarkMode?Theme.of(context).primaryColorLight :ColorResources.buttonTextColorMap[dashboardRecentActivityModel.bookingStatus]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
