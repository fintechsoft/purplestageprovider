import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class BookingDetailsServicemanInfo extends StatelessWidget {
  final String bookingId;
  const BookingDetailsServicemanInfo({super.key,required this.bookingId});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController){
        final bookingDetails =bookingDetailsController.bookingDetailsContent;
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow
        ),
        margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text("Service_Man_Info".tr,
              style: ubuntuMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).primaryColor
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault,),
            Stack(
              children: [
                bookingDetails!.serviceman!=null?
                BottomCard(
                  name: "${bookingDetails.serviceman!.user!.firstName!} ${bookingDetails.serviceman!.user!.lastName!}",
                  phone: bookingDetails.serviceman!.user!.phone!,
                  image: bookingDetails.serviceman?.user?.profileImageFullPath ?? "",
                ):Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor.withOpacity(0.6),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                      )]
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text('missing_serviceman_information'.tr,style: ubuntuRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                        ),),
                        const SizedBox(height: Dimensions.paddingSizeSmall,),
                        Text('this_serviceman_may_deleted'.tr,style: ubuntuRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall,
                        )
                        ),
                      ],
                    ),
                  ),
                ),

                bookingDetailsController.bookingDetailsContent!.bookingStatus=="accepted"||
                bookingDetailsController.bookingDetailsContent!.bookingStatus=="ongoing"?

                Positioned(
                  top: Dimensions.paddingSizeDefault,
                  right: 15,
                  child: InkWell(
                    child: Image.asset(Images.editIcon),
                    onTap: (){
                      Get.find<ServicemanSetupController>().fromBookingDetailsPage(true);
                      bookingDetailsController.showHideExpandView(350);
                    },
                  ),
                )

                 :const SizedBox()
              ],
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault,)
          ],
        ),
      );
    });
  }
}
