import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class SubscriptionItem extends StatelessWidget {
   final int index;
   final SubscriptionModelData subscriptionModelData;
   const SubscriptionItem({super.key,required this.subscriptionModelData, required this.index});

  @override
  Widget build(BuildContext context) {

    int totalNumberOfServices = 0;
    if(subscriptionModelData.subCategory!=null){
      for (var element in subscriptionModelData.subCategory!.services!) {
        if(element.isActive==1){
          totalNumberOfServices++;
        }
      }
    }


    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).cardColor),
            color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          boxShadow: shadow
        ),
      child: Column(
        children: [
          const SizedBox(height:Dimensions.paddingSizeDefault),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomImage(
                    image: "${subscriptionModelData.subCategory?.imageFullPath}",
                    height: 75, width: 75,
                  ),
                ),
              ),
              subscriptionModelData.subCategory != null ?
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subscriptionModelData.subCategory?.name??"",
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(height:Dimensions.paddingSizeExtraSmall),
                    Text(subscriptionModelData.subCategory?.description??"",
                      style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6)
                      ), maxLines: 3, overflow: TextOverflow.ellipsis
                    ),
                  ],
                ),
              )
              : const SizedBox(),
              const SizedBox(width: Dimensions.paddingSizeDefault,)
            ]
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
          Divider(color: Theme.of(context).hintColor.withOpacity(0.5),thickness: 0.5,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,backgroundColor: Colors.transparent
                ),
                onPressed: () => Get.to(ServicesScreen(
                  subscriptionModelData: subscriptionModelData,
                  fromPage: 'subscription_details',
                  index: index,
                ),
                ),
                child: subscriptionModelData.subCategory!=null?Text(
                  "${'see_services'.tr} ($totalNumberOfServices)",
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).primaryColorLight,
                    decoration: TextDecoration.underline,
                  ),
                ):const SizedBox(),
              ),

              const Expanded(flex: 1, child: SizedBox()),

               GetBuilder<SubcategorySubscriptionController>(builder: (mySubscriptionController){
                 return  mySubscriptionController.isSubscribeButtonLoading
                     && mySubscriptionController.selectedSubscriptionIndex==index ?
                 SizedBox(
                   height: 25,
                   width:100,
                   child: Center(
                     child: SizedBox(
                       height: 25,
                       width: 25,
                       child: CircularProgressIndicator(color: Theme.of(context).hoverColor)
                     )
                   ),
                 )
                 : CustomButton(
                   height: 35,
                   width: 120,
                   fontSize: Dimensions.fontSizeSmall,
                   color:  Theme.of(context).colorScheme.tertiary,
                   btnTxt: 'unsubscribe'.tr,
                   onPressed: (){
                     Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet().then((isTrail){
                       if(isTrail){
                         int? isSubscribe = subscriptionModelData.isSubscribed;
                         showCustomBottomSheet(child:  SubscribeUnsubscribeBottomSheet(
                           isSubscribe: isSubscribe == 1 ? false : true,
                           subscriptionModelData : subscriptionModelData,
                           index: index, fromPage: 'subscription_list',
                         ),);
                       }
                     });
                   }
                 );
                 },
               )
              ],
            ),
          ),
          const SizedBox(height:Dimensions.paddingSizeSmall),
        ],
      ),
    );
  }
}
