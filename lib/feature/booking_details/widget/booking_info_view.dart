import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';



class BookingInformationView extends StatelessWidget {
  const BookingInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      final bookingDetails =bookingDetailsController.bookingDetailsContent;
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow
        ),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('${'booking'.tr} # ${bookingDetails!.readableId}',
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9), decoration: TextDecoration.none
                    ),
                  ),
                ),
                (bookingDetails.bookingStatus!="canceled")?
                GestureDetector(
                  onTap: () async {
                    _checkPermission(() async {
                      if(bookingDetailsController.bookingDetailsContent!.serviceAddress!=null){
                        showCustomDialog(child: const CustomLoader());
                        await Geolocator.getCurrentPosition().then((position) {
                          MapUtils.openMap(
                              double.tryParse(bookingDetailsController.bookingDetailsContent!.serviceAddress!.lat!) ?? 23.8103,
                              double.tryParse(bookingDetailsController.bookingDetailsContent!.serviceAddress!.lon!) ?? 90.4125,
                              position.latitude ,
                              position.longitude);
                        });
                        Get.back();
                      }else{
                        showCustomSnackBar("service_address_not_found".tr);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeExtraSmall+2
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Get.isDarkMode?
                      Colors.grey.withOpacity(0.2):ColorResources.buttonBackgroundColorMap[bookingDetails.bookingStatus],
                    ),
                    child: Center(
                      child: Text("view_on_map".tr,
                        style: ubuntuMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color:Get.isDarkMode?Theme.of(context).primaryColorLight : ColorResources.buttonTextColorMap[bookingDetails.bookingStatus]
                        ),
                      ),
                    ),
                  ),
                ):Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: Dimensions.paddingSizeExtraSmall
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Get.isDarkMode?
                    Colors.grey.withOpacity(0.2):ColorResources.buttonBackgroundColorMap[bookingDetails.bookingStatus],
                  ),
                  child: Center(
                    child: Text("canceled".tr,
                      style: ubuntuMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color:Get.isDarkMode?Theme.of(context).primaryColorLight : ColorResources.buttonTextColorMap[bookingDetails.bookingStatus]
                      ),
                    ),
                  ),
                )
              ],
            ),
            if(bookingDetails.bookingStatus!="canceled")
            Padding(padding: const EdgeInsets.only(top: 8.0),
              child: RichText(text:  TextSpan(text: '${'Booking_Status'.tr} : ',
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault-1,
                    color:Theme.of(context).textTheme.bodyLarge!.color,),
                  children: [
                    TextSpan(text: bookingDetailsController.bookingDetailsContent!.bookingStatus!.tr,
                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault-1,
                            color: ColorResources.buttonTextColorMap[bookingDetailsController.bookingDetailsContent!.bookingStatus],
                            decoration: TextDecoration.none)
                    ),
                  ]),
              ),
            ),

            const SizedBox(height:Dimensions.paddingSizeDefault),
            BookingItem(
              img: Images.iconCalendar,
              title: '${'booking_date'.tr} : ',
              subTitle: DateConverter.dateMonthYearTime(
                  DateConverter.isoUtcStringToLocalDate(bookingDetails.createdAt!)),
            ),
            const SizedBox(height:Dimensions.paddingSizeExtraSmall),

            BookingItem(
              img: Images.iconCalendar,
              title: '${'scheduled_date'.tr} : ',
              subTitle: ' ${DateConverter.dateMonthYearTime(DateTime.tryParse(bookingDetails.serviceSchedule!))}',
            ),
            const SizedBox(height:Dimensions.paddingSizeExtraSmall),

            BookingItem(
              img: Images.iconLocation,
              title: '${'service_address'.tr} : ${bookingDetails.serviceAddress !=null?''
                  '${bookingDetails.serviceAddress!.address}'
                  :'address_not_found'.tr
              }',
              subTitle: '',
            ),

          ],
        ),
      );
    });
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr, type : ToasterMessageType.info);
    }else if(permission == LocationPermission.deniedForever) {
      showCustomDialog(child: const PermissionDialog(), barrierDismissible: true);
    }else {
      onTap();
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double destinationLatitude, double destinationLongitude, double userLatitude, double userLongitude) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}