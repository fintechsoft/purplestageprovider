import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class BookingDetailsCustomerInfo extends StatelessWidget {
  const BookingDetailsCustomerInfo({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController) {
        final bookingDetails =bookingDetailsController.bookingDetailsContent;
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow
        ),
        margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [

          Text("Customer_Info".tr,
            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height:Dimensions.paddingSizeDefault),

          BottomCard(
            name: bookingDetails?.serviceAddress?.contactPersonName ?? "${ bookingDetails?.customer?.firstName??""} ${bookingDetails?.customer?.lastName??""}",
            phone:  bookingDetails?.serviceAddress?.contactPersonNumber?? bookingDetails?.customer?.phone?? bookingDetails?.customer?.email??"",
            image: bookingDetails?.customer?.profileImageFullPath??"",
            address: bookingDetails?.serviceAddress?.address??'address_not_found'.tr,
          )

        ]),
      );
    });
  }
}
