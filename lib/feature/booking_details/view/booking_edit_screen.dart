import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';


class BookingEditScreen extends StatefulWidget {
  const BookingEditScreen({super.key});
  @override
  State<BookingEditScreen> createState() => _BookingEditScreenState();

}

class _BookingEditScreenState extends State<BookingEditScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<BookingEditController>().initializedControllerValue(Get.find<BookingDetailsController>().bookingDetailsContent, shouldUpdate: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "edit_booking".tr),
      body: GetBuilder<BookingEditController>(builder: (bookingEditController){

        return SingleChildScrollView(
          child: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              const PaymentStatusButton(),

              TextFieldTitle(title: "serviceman".tr, fontSize: Dimensions.fontSizeLarge,),


              Container(width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2),width: 1)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5), elevation: 2,
                    hint: Text(
                      bookingEditController.selectedServiceman == null?
                      "select_serviceman".tr : "${bookingEditController.selectedServiceman?.firstName?? ""} ${bookingEditController.selectedServiceman?.lastName?? ""}",
                      style: ubuntuRegular.copyWith(
                        color: bookingEditController.selectedServiceman == null ?
                        Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6) :
                        Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                      ),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: Get.find<ServicemanSetupController>().servicemanList?.map((ServicemanModel serviceman) {
                      return DropdownMenuItem(
                        value: serviceman,
                        child: Row( children: [
                          Text("${serviceman.firstName ?? ""} ${serviceman.lastName??""}",
                            style: ubuntuRegular.copyWith(
                                 color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                            ),
                          ),
                        ]),
                      );
                    }).toList(),
                    onChanged: (ServicemanModel? newValue)  => bookingEditController.updateSelectedServiceman(newValue),

                  ),
                ),
              ),

              Container(width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2),width: 1)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                      elevation: 2,
                      hint: Text(bookingEditController.selectedBookingStatus ==''?
                      "select_booking_status".tr : "${'booking_status'.tr} :   ${bookingEditController.selectedBookingStatus.tr}",
                        style: ubuntuRegular.copyWith(
                            color: bookingEditController.selectedBookingStatus ==''?
                            Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):
                            Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: bookingEditController.statusTypeList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Row(
                            children: [
                              Text(items.tr,
                                style: ubuntuRegular.copyWith(
                                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {

                        if(Get.find<BookingDetailsController>().bookingDetailsContent?.bookingStatus == "ongoing" && newValue?.toLowerCase() == "accepted"){
                          showCustomSnackBar('service_is_already_ongoing'.tr, type : ToasterMessageType.info);
                          bookingEditController.changeBookingStatusDropDownValue("ongoing");
                        }else{
                          bookingEditController.changeBookingStatusDropDownValue(newValue!);
                        }
                      }
                  ),
                ),
              ),
              TextFieldTitle(title: "service_schedule".tr, fontSize: Dimensions.fontSizeLarge,),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2),width: 1)
                ),
                margin: const EdgeInsets.only(bottom : Dimensions.paddingSizeDefault),
                padding: const EdgeInsets.only(left : Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                  (bookingEditController.scheduleTime != null)?
                  Text(DateConverter.dateMonthYearTime(DateTime.tryParse(bookingEditController.scheduleTime!)),
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    textDirection: TextDirection.ltr,
                  ): const SizedBox(),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),

                  IconButton(onPressed: () async {
                    Get.find<UserProfileController>().trialWidgetShow(route: "show-dialog");
                    await bookingEditController.selectDate();
                    Get.find<UserProfileController>().trialWidgetShow(route: "");
                    },
                    icon:  Icon(Icons.calendar_month_outlined, color: Theme.of(context).primaryColor.withOpacity(0.5),),
                  )

                ],),
              ),

              Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [
                Text('service_list'.tr, style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
                TextButton(
                  onPressed: bookingEditController.cartList.length == 1 &&  bookingEditController.cartList[0].variantKey == null ? null : (){
                    showModalBottomSheet(
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context, builder: (context) => SubcategoryServiceView (
                      categoryId: "", subCategoryId: '', serviceList: bookingEditController.serviceList??[],)
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      side: BorderSide(color: bookingEditController.cartList.length == 1 &&  bookingEditController.cartList[0].variantKey == null?
                      Theme.of(context).hintColor : Theme.of(context).primaryColor), // Customize the border color here
                    ),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.add, color: bookingEditController.cartList.length == 1 &&  bookingEditController.cartList[0].variantKey == null ?
                    Theme.of(context).hintColor : Theme.of(context).primaryColor,
                      size: Dimensions.fontSizeDefault,
                    ),
                    const SizedBox(width: 8.0), // Adjust the spacing between the icon and text here
                    Text("add_service".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: bookingEditController.cartList.length == 1 &&  bookingEditController.cartList[0].variantKey == null
                          ? Theme.of(context).hintColor : Theme.of(context).primaryColor,
                    ),),
                  ]),
                )
              ],),

              const SizedBox(height: Dimensions.paddingSizeDefault,),

              GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeLarge,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ?
                  Dimensions.paddingSizeLarge :
                  Dimensions.paddingSizeSmall,
                  childAspectRatio: ResponsiveHelper.isMobile(context) ?  5 : 6 ,
                  crossAxisCount: 1,
                  mainAxisExtent: 110,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bookingEditController.cartList.length,
                itemBuilder: (context, index) {
                  bool disableQuantityButton  = bookingEditController.cartList.length == 1 &&  bookingEditController.cartList[0].variantKey == null;
                  return  CartServiceWidget(cart: bookingEditController.cartList[index], cartIndex: index, disableQuantityButton: disableQuantityButton,);
                },
              ),

              const SizedBox(height: 90,),


            ],),
          ),
        );
      }),

      bottomSheet: GetBuilder<BookingEditController>(builder: (bookingEditController){
        return Container(
          color: Theme.of(context).cardColor,
          height: 85, child: Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
           child:  CustomButton(
            btnTxt: "update_status".tr,
            isLoading: bookingEditController.statusUpdateLoading,
            onPressed: (){
              bookingEditController.updateBooking(
                bookingId : Get.find<BookingDetailsController>().bookingDetailsContent?.id,
                zoneId : Get.find<BookingDetailsController>().bookingDetailsContent?.zoneId
              );
            },
          ),
        ),
        );
      }),
    );
  }
}
