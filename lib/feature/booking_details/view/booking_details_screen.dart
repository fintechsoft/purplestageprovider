import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;
  final String bookingStatus;
  final String? fromPage;
  final String subcategoryId;
  const BookingDetailsScreen( {
    super.key,required this.bookingId,
    required this.bookingStatus,
    this.fromPage, required this.subcategoryId});
  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}
class _BookingDetailsScreenState extends State<BookingDetailsScreen> with SingleTickerProviderStateMixin {
  TabController? controller;

  final couponTooltipController = JustTheController();
  final serviceTooltipController = JustTheController();

  @override
  void initState() {
    Get.find<BookingDetailsController>().showHideExpandView(0, shouldUpdate: false);
    super.initState();
    Get.find<BookingDetailsController>().setBookingDetailsContent = null;
    Get.find<BookingDetailsController>().setBookingDetailsModel = null;
    controller = TabController(vsync: this, length: 2);
    controller?.addListener(() {
      Get.find<BookingDetailsController>().updateServicePageCurrentState(
        controller?.index == 0 ? BookingDetailsTabControllerState.bookingDetails :
            BookingDetailsTabControllerState.status
      );
    });

    Get.find<BookingDetailsController>().updateServicePageCurrentState(BookingDetailsTabControllerState.bookingDetails, shouldUpdate: false);

    Get.find<BookingDetailsController>().getBookingDetailsData(widget.bookingId);
    Get.find<BookingDetailsController>().pickPhotoEvidence(isRemove:true, isCamera: false);
   Get.find<ServicemanSetupController>().getAllServicemanList(1,reload: false, status: 'active');

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
     onPopInvoked: (){
       if(widget.fromPage == 'fromNotification') {
         Get.offAllNamed(RouteHelper.getInitialRoute());
       }
     },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(
          title: 'booking_details'.tr,
          onBackPressed: (){
            if(widget.fromPage == 'fromNotification'){
              Get.offAllNamed(RouteHelper.getInitialRoute());
            }else{
              Get.back();
            }
          },
        ),

        body: SafeArea(
          bottom: false,
          child: GetBuilder<BookingDetailsController>(
            builder: (bookingDetailsController) {

              return ExpandableBottomSheet(

                expandableContent: bookingDetailsController.bottomSheetHeight == 0 ?
                const SizedBox() : AssignServicemanScreen(
                  servicemanList: Get.find<ServicemanSetupController>().servicemanList ?? [],
                  bookingId: widget.bookingId,
                  reAssignServiceman: bookingDetailsController.bookingDetailsContent?.serviceman !=null ? true : false,
                ),

                persistentContentHeight: bookingDetailsController.bottomSheetHeight,

                background: Scaffold( backgroundColor: Theme.of(context).colorScheme.surface,
                  body:Column( children: [

                    Container(
                      height: 45,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(
                        border:  Border(
                          bottom: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.7), width: 1),
                        ),
                      ),
                      child: TabBar(
                        unselectedLabelColor:Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                        indicatorColor: Theme.of(context).primaryColor,
                        controller: controller,
                        labelColor: Theme.of(context).primaryColorLight,
                        labelStyle:  ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        labelPadding: EdgeInsets.zero,
                        onTap: (int? index) {
                          switch (index) {
                            case 0:
                              bookingDetailsController.updateServicePageCurrentState(BookingDetailsTabControllerState.bookingDetails);
                              break;
                            case 1:
                              bookingDetailsController.updateServicePageCurrentState(BookingDetailsTabControllerState.status);
                              bookingDetailsController
                                  .showHideExpandView(0);
                              break;
                          }
                        },
                        tabs: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.5,child: Tab(text: 'booking_details'.tr)),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.5, child: Tab(text: 'status'.tr)),
                        ],
                      ),
                    ),

                    Expanded(
                      child: TabBarView(controller: controller ,children: [
                        BookingDetailsWidget(
                          bookingId: widget.bookingId,
                          couponTooltipController: couponTooltipController,
                          serviceTooltipController: serviceTooltipController,
                        ) ,
                        BookingStatus(bookingId: widget.bookingId,),
                      ]),
                    ),

                  ]),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
