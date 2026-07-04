import 'package:purplestage_provider/utils/core_export.dart';
import 'package:purplestage_provider/feature/reporting/model/booking_report_model.dart';
import 'package:get/get.dart';

class BookingReportListView extends StatelessWidget {
  final List<BookingFilterData> bookingFilterData;
  const BookingReportListView({super.key, required this.bookingFilterData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
        bookingFilterData.isNotEmpty?
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                  horizontal: Dimensions.paddingSizeDefault
              ),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:0.2),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Column(
                        children: [

                          Row(
                            children: [


                              Text('booking_id'.tr,
                                style: ubuntuMedium.copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              Text(" #${bookingFilterData[index].readableId.toString()}",
                                style: ubuntuMedium.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Row(
                            children: [
                              Text("${'customer_name'.tr} : ",
                                style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              Text("${bookingFilterData[index].customer?.firstName ??""} ${bookingFilterData[index].customer?.lastName ??""}" ,
                                style: ubuntuMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeSmall
                      ),
                      child: Column(children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('booking_amount'.tr,
                              style: ubuntuMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalBookingAmount.toString())),
                              style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('service_discount'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalDiscountAmount.toString())),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('coupon_discount'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalCouponDiscountAmount.toString())),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('VAT/Tax'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalTaxAmount.toString())),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        )

                      ]),
                    ),


                  ],
                ),
              ),
            );
          },
          itemCount: bookingFilterData.length,
        ) :
        SizedBox(height: Get.height*0.33,
          child: Center(
            child: Text('no_data_found'.tr,style: ubuntuRegular.copyWith(color:Theme.of(context).primaryColorLight)),
          ),),
        if(Get.find<BookingReportController>().isLoading)
          const CircularProgressIndicator()
      ],
    );
  }
}
