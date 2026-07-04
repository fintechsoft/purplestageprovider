import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class SubscribeUnsubscribeBottomSheet extends StatelessWidget {
  final bool isSubscribe;
  final ServiceSubCategoryModel? subCategoryModel;
  final SubscriptionModelData? subscriptionModelData;
  final int index;
  final String fromPage;
  const SubscribeUnsubscribeBottomSheet({super.key, required this.isSubscribe, this.subCategoryModel, required this.index, this.subscriptionModelData, required this.fromPage});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceCategoryController>(builder: (controller){
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius : const BorderRadius.only(
            topLeft: Radius.circular(Dimensions.paddingSizeDefault),
            topRight : Radius.circular(Dimensions.paddingSizeDefault),
          ),
        ),
        child: Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [


            Container(height: 5, width: 40, decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
            ),),
            const SizedBox(height: Dimensions.paddingSizeLarge),


            Image(image: AssetImage(Images.settingsLoading),
                height: 100,
                width: 100
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(isSubscribe ? "ready_to_provide".tr : "are_you_sure_to_unsubscribe".tr ,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),


            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeLarge * 1.5,
                  right: Dimensions.paddingSizeLarge * 1.5
              ),
              child: Text(!isSubscribe ? "not_get_any_notification_for_unsubscription".tr : subCategoryModel?.name ?? "",
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),


            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeExtraLarge,
                  right: Dimensions.paddingSizeExtraLarge
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Expanded(child: CustomButton(
                      btnTxt: 'no'.tr,
                      isLoading: controller.isSubscriptionLoading,
                      isShowLoadingButton: false,
                      color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                      onPressed: () => Get.back(),
                      textColor: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.8)
                  )),
                  const SizedBox(width: Dimensions.paddingSizeDefault),


                  Expanded(child: CustomButton(
                    isLoading: controller.isSubscriptionLoading,
                    btnTxt: isSubscribe ? 'yes_subscribe'.tr : 'unsubscribe'.tr,
                    onPressed: () async {

                      ResponseModel response = await controller.changeSubscriptionStatus(
                        subCategoryModel?.id ?? subscriptionModelData?.subCategoryId?? "",
                        index,
                        fromPage: fromPage,
                      );
                      if(!response.isSuccess!){
                        showCustomSnackBar(response.message);
                      }else{
                        Get.back();
                      }
                    },
                    transparent: false,
                    color: isSubscribe ? null : Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
                  )),


                ],),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge * 2),


          ],),
        ),
      );
    });
  }
}