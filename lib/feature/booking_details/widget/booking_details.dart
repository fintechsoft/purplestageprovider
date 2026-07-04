import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class BookingDetailsWidget extends StatelessWidget {
  final String bookingId;
  final JustTheController? couponTooltipController;
  final JustTheController? serviceTooltipController;
  const BookingDetailsWidget({super.key, required this.bookingId, this.couponTooltipController, this.serviceTooltipController});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      initState: (_)=>  Get.find<BookingDetailsController>().showHideExpandView(0, shouldUpdate: false),
      builder: (bookingDetailsController) {
        if(bookingDetailsController.bookingDetailsContent == null && bookingDetailsController.bookingDetailsModel == null){
          return const Center(child: BookingDetailsShimmer());
        } else if( bookingDetailsController.bookingDetailsModel != null && bookingDetailsController.bookingDetailsModel!.content ==null){
          return SizedBox(height: Get.height * 0.7, child:  BookingEmptyScreen (bookingId: bookingId,));

        }else{

          final bookingDetails = bookingDetailsController.bookingDetailsContent;
          ConfigModel configModel = Get.find<SplashController>().configModel;
          String bookingStatus = bookingDetails?.bookingStatus ?? "";
          int isGuest = bookingDetails?.isGuest ?? 0;
          bool isPartial = (bookingDetails!.partialPayments !=null && bookingDetails.partialPayments!.isNotEmpty) ? true : false ;

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(child: Column(children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    bookingDetails.bookingStatus!='pending'?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width:Dimensions.paddingSizeDefault),

                        Expanded(child: CustomButton(btnTxt: "edit_booking".tr, icon: Icons.edit,
                          onPressed: (configModel.content?.providerCanEditBooking == 1 && !isPartial && (bookingStatus == "accepted" || bookingStatus == "ongoing") && (isGuest == 1 && bookingDetails.paymentMethod != "cash_after_service" ? false : true)) ? (){
                          Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet().then((isTrail){
                            if(isTrail){
                              Get.to(()=> const BookingEditScreen());
                            }
                          });
                        } :  null)),

                        const SizedBox(width:Dimensions.paddingSizeSmall),

                        CustomButton(width: 120, color: Colors.blue,
                          icon: Icons.file_present, btnTxt: "invoice".tr,
                          onPressed: () async {
                            showCustomDialog(child: const CustomLoader());
                            String languageCode = Get.find<LocalizationController>().locale.languageCode;
                            String uri = "${AppConstants.baseUrl}${AppConstants.invoiceUrl}${bookingDetails.id}/$languageCode";
                            if (kDebugMode) {
                              print("Uri : $uri");
                            }
                            await _launchUrl(Uri.parse(uri));
                            Get.back();

                            // var pdfFile = await PdfInvoiceApi.generate(
                            //     bookingDetails,bookingDetailsController.invoiceItems,
                            //     bookingDetailsController
                            // );
                            // PdfApi.openFile(pdfFile);
                          },
                        ),
                        const SizedBox(width:Dimensions.paddingSizeDefault),
                      ]
                    ) :const SizedBox.shrink(),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                    const BookingInformationView(),

                    BookingSummeryView(
                      bookingDetailsContent: bookingDetailsController.bookingDetailsContent!,
                      couponTooltipController: couponTooltipController,
                      serviceTooltipController: serviceTooltipController,
                    ),

                    const PaymentInfoView(),

                    bookingDetails.bookingStatus=='accepted'&& bookingDetails.serviceman == null ?
                    GetBuilder<ServicemanSetupController>(builder: (servicemanSetupController){
                      return Padding(
                        padding:  const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge,
                          vertical: Dimensions.paddingSizeSmall,
                        ),
                        child: !servicemanSetupController.isLoading ? CustomButton(
                          btnTxt: "Assign_service_man".tr,
                          onPressed: () => bookingDetailsController.showHideExpandView(350),
                        ) : CircularProgressIndicator(color: Theme.of(context).hoverColor,),
                      );
                    }) : bookingDetails.bookingStatus !='pending' && bookingDetails.serviceman != null ?
                    BookingDetailsServicemanInfo( bookingId: bookingId) :
                    const SizedBox.shrink(),

                    const BookingDetailsCustomerInfo(),

                    const ServiceCompletedPhotoEvidence(),

                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,)
                  ],),
                  ),
                ),

                ((bookingDetailsController.bookingDetailsContent != null) && (bookingDetailsController.bookingDetailsContent?.bookingStatus == "pending"
                    || bookingDetailsController.bookingDetailsContent?.bookingStatus == "accepted" || bookingDetailsController.bookingDetailsContent?.bookingStatus == "ongoing" )
                    ) ?
                ChangeStatusDropdownButton(
                  bookingDetails: bookingDetailsController.bookingDetailsContent!,
                  bookingId: bookingDetails.id!,
                ) : const SizedBox(),

                const SizedBox(height: Dimensions.paddingSizeDefault,)
              ],
            ),

            floatingActionButton: bookingDetailsController.isShowChattingButton() ?
            Padding(padding:  EdgeInsets.only(bottom: GetPlatform.isAndroid ? 70 : 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 48, width: 48,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),

                      heroTag: "1",
                      elevation: 0.0,
                      backgroundColor: Colors.green,
                      onPressed: () async => await  launchUrl(Uri(
                        scheme: 'tel',
                        path: bookingDetails.serviceAddress?.contactPersonNumber ?? "",
                      ),mode: LaunchMode.externalApplication,
                      ),
                      child: Icon(Icons.call,color: light.cardColor, size: 20,),
                    ),
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                  SizedBox(height: 48, width: 48,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      heroTag: "2",
                      elevation: 0.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        if(Get.find<UserProfileController>().checkAvailableFeatureInSubscriptionPlan(featureType: "chat")){
                          showCustomBottomSheet(child: const CreateChannelDialog());
                        }
                      },
                      child: Icon(Icons.message_rounded,color: light.cardColor,size: 18,),
                    ),
                  ),
                ],
              ),
            ) : null,
          );
        }
      },
    );
  }
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

class BookingEmptyScreen extends StatelessWidget {
  final String bookingId;
  const BookingEmptyScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Image.asset(Images.noResults, height: Get.height * 0.1, color: Theme.of(context).primaryColor,),
      const SizedBox(height: Dimensions.paddingSizeLarge,),
      Text("information_not_found".tr, style: ubuntuRegular,),
      const SizedBox(height: Dimensions.paddingSizeLarge,),

      CustomButton(
        height: 35, width: 120, radius: Dimensions.radiusExtraLarge,
        btnTxt: "go_back".tr, onPressed: () {
          Get.find<BookingRequestController>().removeBookingItemFromList(bookingId, shouldUpdate: true , bookingStatus: "");
        Get.back();
      },)

    ],),);
  }
}




