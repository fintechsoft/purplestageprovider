import 'package:purplestage_provider/feature/subscriptions/widget/subcategory/subscription_item_shimmer.dart';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: "mySubscription".tr,),
      body: GetBuilder<SubcategorySubscriptionController>(
        initState: (_){
          Get.find<SubcategorySubscriptionController>().getMySubscriptionData(1, false);
        },
        builder: (mySubscriptionController){
          return
            !mySubscriptionController.isLoading && mySubscriptionController.subscriptionList.isNotEmpty?
          CustomScrollView(
            controller: mySubscriptionController.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 36,
                  width: double.infinity,
                  child: Center(
                    child: RichText(
                      text:  TextSpan(
                        text: 'you_have'.tr,
                        style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: mySubscriptionController.totalSubscription.toString(),
                            style: ubuntuBold.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                          TextSpan(
                            text: mySubscriptionController.totalSubscription!>1
                                ? 'subscriptions'.tr:'subscription'.tr,
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context,index){
                        if(mySubscriptionController.subscriptionList[index].subCategory!=null){
                          return SubscriptionItem(subscriptionModelData: mySubscriptionController.subscriptionList[index], index: index);
                        }else{
                          return const SizedBox.shrink();
                        }
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mySubscriptionController.subscriptionList.length,
                    ),
                    mySubscriptionController.isPaginationLoading?
                    CircularProgressIndicator(color: Theme.of(context).hoverColor,):const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ) :
            !mySubscriptionController.isLoading && mySubscriptionController.subscriptionList.isEmpty ?
          const NoDataScreen(
              text: "no_subscription_found",
            type: NoDataType.subscriptions,
          ): const SubscriptionItemShimmer();
      })
    );
  }
}
