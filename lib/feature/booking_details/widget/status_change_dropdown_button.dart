import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ChangeStatusDropdownButton extends StatelessWidget {
  final BookingDetailsContent bookingDetails;
  final String bookingId;
  const ChangeStatusDropdownButton({
    super.key,
    required this.bookingDetails,
    required this.bookingId});

  @override
  Widget build(BuildContext context) {



    return GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      return  Padding(
        padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,0,  Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
        child: Column(
          children: [
            bookingDetails.bookingStatus == 'pending'?
            CustomButton(
              btnTxt: "Accept_Booking_Request".tr,
              color:Get.isDarkMode? Colors.green.withOpacity(0.5):Colors.green,
              isLoading: bookingDetailsController.isAcceptButtonLoading,
              icon: Icons.file_present,
              onPressed:  (){
                if(Get.find<UserProfileController>().providerModel?.content?.subscriptionInfo?.subscribedPackageDetails?.isCanceled == 1){
                  showCustomSnackBar("your_subscription_plan_has_been_cancelled_you_will_not_able_to_accept_any_booking_request".tr, type : ToasterMessageType.info);
                }else{
                  Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet().then((isTrial){
                    if(isTrial){
                      showCustomDialog(child:  ConfirmationDialog(
                        yesButtonColor: Theme.of(Get.context!).primaryColor,
                        title: "want_accept_this_booking?".tr,
                        icon: Images.servicemanImage,
                        description: ''.tr,
                        onYesPressed: (){
                          bookingDetailsController.acceptBookingRequest(bookingId);
                          Get.back();
                        },
                        onNoPressed: () => Get.back(),

                      ),);
                    }
                  });
                }
              },
            ) : bookingDetailsController.dropDownValue == "completed" && bookingDetailsController.showPhotoEvidenceField && Get.find<SplashController>().configModel.content?.bookingOtpVerification == 1?
            CustomButton(btnTxt: "request_for_otp".tr, onPressed: () {
              bookingDetailsController.sendBookingOTPNotification(bookingId, shouldUpdate: false);
              showCustomBottomSheet(child: OtpVerificationBottomSheet(bookingId: bookingId));

            },) :
            Row(
              children: [
                Expanded(
                  child: PopupMenuButton<String>(
                    onSelected: (String newValue) {
                      bookingDetailsController.changeBookingStatusDropDownValue(newValue);
                      if(newValue == "completed"){
                        if(Get.find<SplashController>().configModel.content?.bookingImageVerification == 1 && bookingDetailsController.pickedPhotoEvidence.isNotEmpty){
                          bookingDetailsController.changePhotoEvidenceStatus(status: true);
                        }else if(Get.find<SplashController>().configModel.content?.bookingOtpVerification == 1) {
                          bookingDetailsController.changePhotoEvidenceStatus(status: true);
                        }else{
                          bookingDetailsController.changePhotoEvidenceStatus(status: false);
                        }
                        if(Get.find<SplashController>().configModel.content?.bookingImageVerification == 1  && bookingDetailsController.pickedPhotoEvidence.isEmpty){
                          showCustomBottomSheet(child: CameraButtonSheet(bookingId: bookingId,),);
                        }
                      }
                    },
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - (160)
                    ),
                    offset: const Offset(0, 250),
                    elevation: 2,
                    surfaceTintColor : Theme.of(context).cardColor,
                    itemBuilder: (BuildContext context) {
                      return bookingDetailsController.statusTypeList.map((String items) {
                        return PopupMenuItem<String>(
                          value: items,
                          padding: EdgeInsets.zero,
                          child:  bookingDetailsController.dropDownValue.tr.toLowerCase() == items ?
                          Container(
                            color: Theme.of(context).primaryColor.withOpacity(0.08),
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 10),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(items.tr, style: ubuntuMedium.copyWith(
                                    color: Theme.of(context).primaryColor
                                ),),
                                Icon(Icons.done, color: Theme.of(context).primaryColor),
                              ],
                            ),
                          ) : Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: Text(items.tr),
                          ),
                        );
                      }).toList();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          border: Border.all(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5), width: 0.8)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(bookingDetailsController
                            .dropDownValue.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7))
                        ),
                        Icon(Icons.keyboard_arrow_down_sharp, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                      ],),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault,),

                bookingDetailsController.isStatusUpdateLoading ?
                SizedBox(height: 45, width: 112,
                  child: Center(
                      child: SizedBox( height: 30,width: 30,
                        child: CircularProgressIndicator(color: Theme.of(context).hoverColor),
                      )
                  ),
                ) : CustomButton(
                  color: Theme.of(context).primaryColor, height: 45, width: 112, btnTxt: "change".tr,
                  onPressed: bookingDetails.bookingStatus=="completed"
                      || bookingDetailsController.dropDownValue==bookingDetails.bookingStatus || bookingDetails.bookingStatus=="canceled"
                      ? null : ()=> bookingDetailsController.changeBookingStatus(bookingId,bookingStatus: bookingDetails.bookingStatus),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
