import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class MySubscriptionSection extends StatelessWidget {
  const MySubscriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (dashboardController){
        return dashboardController.dashboardSubscriptionList.isEmpty ?
        const SizedBox() : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault+3, vertical: Dimensions.paddingSizeDefault,),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              Row(
                children: [
                  Image.asset(Images.dashboardProfile,height: 15,width:15),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  Text("mySubscription".tr,
                    style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: ()=> Get.toNamed(RouteHelper. getMySubscriptionRoute()),
                child: Text("view_all".tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.tertiary
                  ),
                ),
             ),
            ],),
          ),

          Container(height: 120,
            color: Theme.of(context).cardColor.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 100,
              child: ListView.builder(scrollDirection: Axis.horizontal,
                  itemBuilder:(context, index) {
                if(dashboardController.dashboardSubscriptionList[index].subCategory!=null){
                  return SubscriptionCardItem(subscriptionModelData: dashboardController.dashboardSubscriptionList[index], index: index,);
                }else{
                  return const SizedBox();
                }
                 },
                  itemCount: dashboardController.dashboardSubscriptionList.length
              ),
            ),
          ),

        ],);
    },);
  }
}
