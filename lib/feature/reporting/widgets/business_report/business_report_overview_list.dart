import 'package:purplestage_provider/utils/core_export.dart';
import 'package:purplestage_provider/feature/reporting/model/business_report_overview_model.dart';
import 'package:get/get.dart';

class BusinessReportOverviewListView extends StatelessWidget {
  final  List<Amounts>  filterData;
  const BusinessReportOverviewListView({super.key, required this.filterData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filterData.isNotEmpty?
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){

            double totalEarning=0;
            double totalExpense=0;
            double netProfit=0;
            double netProfitRate=0;
            double tax =0;

            totalEarning = filterData[index].providerEarning??0;
            tax = filterData[index].serviceTax??0;

            totalExpense = filterData[index].campaignDiscountByProvider!
                + filterData[index].couponDiscountByProvider! + filterData[index].discountByProvider!;

            netProfit = totalEarning;
            netProfitRate =totalEarning!=0? (netProfit*100)/totalEarning  : netProfit*100;

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraSmall,
                horizontal: Dimensions.paddingSizeDefault
              ),
              child: Container(width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:0.2),
                ),

                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      decoration:  BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radiusSmall),
                            topRight: Radius.circular(Dimensions.radiusSmall),
                        ),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text('net_profit_rate'.tr,
                            style: ubuntuMedium.copyWith(
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                          Text("${netProfitRate.toStringAsFixed(2)} % ",
                            style: ubuntuBold.copyWith(color: Theme.of(context).primaryColorLight),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text('total_earning'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).hintColor.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(totalEarning),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text('total_expenses'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).hintColor.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(totalExpense),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text('tax'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).hintColor.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(tax),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                        CustomDivider(color: Theme.of(context).hintColor.withOpacity(0.2)),
                        const SizedBox(height: Dimensions.paddingSizeSmall),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${'net_profit'.tr} : ",
                              style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(netProfit),
                              style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),


                      ]),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: filterData.length,
        ):
        SizedBox(height: Get.height*0.33,
          child: const Center(
           child: NoDataScreen(text: "", type: NoDataType.others,),
        ),),

        if(Get.find<BusinessReportController>().isLoading)
          const CircularProgressIndicator()
      ],
    );
  }
}
