import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class BookingRequestItem extends StatelessWidget {
  final BookingRequestModel bookingRequestModel;
  const BookingRequestItem({
    super.key, required this.bookingRequestModel,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow,
      ),
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
      child: Stack(
        children: [

          Column(crossAxisAlignment: CrossAxisAlignment.start , children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraSmall+3,
              ),
              child: Row(children: [ Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("booking".tr,
                          style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                          ),
                        ),
                        Text(" # ${bookingRequestModel.readableId}",
                          style: ubuntuBold.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(bookingRequestModel.subCategory?.name ?? " ",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall + 2,  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),),

                  const SizedBox(width: Dimensions.paddingSizeDefault,),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall,
                      horizontal: Dimensions.paddingSizeDefault,
                    ),
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(50),
                      color: Get.isDarkMode?Colors.grey.withOpacity(0.2):
                      ColorResources.buttonBackgroundColorMap[bookingRequestModel.bookingStatus],
                    ),
                    child: Center(
                      child: Text('${bookingRequestModel.bookingStatus}'.tr,
                        style:ubuntuMedium.copyWith(fontWeight: FontWeight.w500, fontSize: 12,
                          color:ColorResources.buttonTextColorMap[bookingRequestModel.bookingStatus],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 2,width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      Row(
                        children: [
                          Text("${'booking_date'.tr}: ",
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,   color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6))
                          ),
                          Expanded(
                            child: Text(" ${DateConverter.dateMonthYearTime(DateConverter
                                .isoUtcStringToLocalDate(bookingRequestModel.createdAt!))}",
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,   color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)),
                                textDirection: TextDirection.ltr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                      Row(
                        children: [
                          Text("${'scheduled_date'.tr}: ",
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall ,  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6))
                          ),
                          Expanded(
                            child: Text(DateConverter.dateMonthYearTime(DateTime.tryParse(bookingRequestModel.serviceSchedule!)),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall ,  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)),
                              textDirection: TextDirection.ltr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('total_amount'.tr,
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,  color: Theme.of(context).secondaryHeaderColor),
                      ),
                      Text(PriceConverter.convertPrice(double.parse(bookingRequestModel.totalBookingAmount)),
                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],),
          Positioned.fill(child: CustomInkWell(
            onTap: ()=>Get.toNamed(RouteHelper.getBookingDetailsRoute(bookingRequestModel.id!, bookingRequestModel.bookingStatus!,'others', subcategoryId: bookingRequestModel.subCategoryId)),
          ))
        ],
      ),
    );
  }
}
