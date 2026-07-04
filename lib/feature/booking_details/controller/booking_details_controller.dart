import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class BookingDetailsController extends GetxController implements GetxService{
  final BookingDetailsRepo bookingDetailsRepo;
  BookingDetailsController({required this.bookingDetailsRepo});



  final List<String> statusTypeList = [
    "accepted",
    "ongoing",
    "completed",
    "canceled",
  ];


  String dropDownValue = '';

  ScrollController scrollController  = ScrollController();
  ScrollController completedServiceImagesScrollController  = ScrollController();

  String _otp = '';
  String get otp => _otp;

  bool _isAcceptButtonLoading = false;
  bool get isAcceptButtonLoading => _isAcceptButtonLoading;

  bool _isStatusUpdateLoading = false;
  bool get isStatusUpdateLoading => _isStatusUpdateLoading;

  bool _showPhotoEvidenceField = false;
  bool get showPhotoEvidenceField => _showPhotoEvidenceField;

  bool _isWrongOtpSubmitted = false;
  bool get isWrongOtpSubmitted => _isWrongOtpSubmitted;

  List<XFile> _photoEvidence = [];
  List<XFile> get pickedPhotoEvidence => _photoEvidence;

  bool _hideResendButton = false;
  bool get hideResendButton => _hideResendButton;

  bool _paymentStatusPaid = true;
  bool get paymentStatusPaid => _paymentStatusPaid;

  ServicemanModel? _selectedServiceman;
  ServicemanModel? get selectedServiceman => _selectedServiceman;


  BookingDetailsContent? _bookingDetailsContent;
  BookingDetailsContent? get bookingDetailsContent => _bookingDetailsContent;

  BookingDetailsModel? _bookingDetailsModel;
  BookingDetailsModel? get bookingDetailsModel => _bookingDetailsModel;



  bool _isExpand = true;
  bool get isExpand => _isExpand;

  double _bottomSheetHeight = 0;
  double get bottomSheetHeight => _bottomSheetHeight;

  var bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;

  String initialBookingStatus = 'pending';
  bool isAssignedServiceman = false;

  final DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  final TimeOfDay _selectedTimeOfDay = TimeOfDay.now();
  TimeOfDay get selectedTimeOfDay => _selectedTimeOfDay;

  final String _schedule = '';
  String get schedule => _schedule;

  List<InvoiceItem> _invoiceItems =[];
  List<InvoiceItem> get invoiceItems => _invoiceItems;

  List<double> _unitTotalCost =[];
  double _allTotalCost = 0;
  double _totalDiscount =0;
  double _totalDiscountWithCoupon =0;
  List<double> get unitTotalCost => _unitTotalCost;
  double get allTotalCost => _allTotalCost;
  double get totalDiscount => _totalDiscount;
  double get totalDiscountWithCoupon => _totalDiscountWithCoupon;

  set setBookingDetailsContent(BookingDetailsContent? value) => _bookingDetailsContent = value;
  set setBookingDetailsModel(BookingDetailsModel? value) => _bookingDetailsModel = value;


  @override
  void onInit() {
    super.onInit();
    if(Get.find<SplashController>().configModel.content?.providerCanCancelBooking == 0){
      statusTypeList.remove('canceled');
    }

  }

  Future<void> getBookingDetailsData(String bookingID,{bool reload = true}) async {

    Response response = await bookingDetailsRepo.getBookingDetailsData(bookingID);

    if(response.statusCode == 200 && response.body["response_code"] == "default_200"){
      _bookingDetailsContent = BookingDetailsContent.fromJson(response.body['content']);


      if(_bookingDetailsContent != null && _bookingDetailsContent?.subcategoryId != null){
        Get.find<BookingEditController>().getServiceListBasedOnSubcategory(subCategoryId : _bookingDetailsContent!.subcategoryId!);
      }

      Get.find<BookingEditController>().initializedControllerValue(_bookingDetailsContent!);

      initialBookingStatus =_bookingDetailsContent!.bookingStatus!;
      _paymentStatusPaid = _bookingDetailsContent?.isPaid == 1 ? true : false;
      _selectedServiceman = _bookingDetailsContent?.serviceman?.user;

      if(_bookingDetailsContent!.serviceman!=null){
        isAssignedServiceman = true;
      }
      _unitTotalCost=[];
      for (var element in _bookingDetailsContent!.bookingDetails!) {
        _unitTotalCost.add( element.serviceCost! * element.quantity!);
      }
      _allTotalCost=0;
      for (var element in _unitTotalCost) {
        _allTotalCost=_allTotalCost+element;
      }

      double discount= _bookingDetailsContent?.totalDiscountAmount ?? 0;
      double campaignDiscount= double.tryParse(_bookingDetailsContent?.totalCampaignDiscountAmount ?? "0" ) ?? 0;
      _totalDiscount = (discount+campaignDiscount);
      _totalDiscountWithCoupon = discount+campaignDiscount+(double.tryParse(_bookingDetailsContent!.totalCouponDiscountAmount!)!);

      _invoiceItems =[];
      for (var element in _bookingDetailsContent!.bookingDetails!) {
        double discountAmount = element.discountAmount! + (element.campaignDiscountAmount!) +(element.overallCouponDiscountAmount!);
        _invoiceItems.add(
            InvoiceItem(
              discountAmount: discountAmount.toPrecision(2),
              tax: element.taxAmount!.toPrecision(2),
              unitAllTotal: element.totalCost!.toPrecision(2),
              quantity: element.quantity!,
              serviceName: "${element.serviceName?? 'service_deleted'.tr }"
                  "\n${element.variantKey?.replaceAll('-', ' ').capitalizeFirst ?? ' '}" ,
              variationName: element.variantKey?.replaceAll('-', ' ').capitalizeFirst ?? ' ' ,
              unitPrice: element.serviceCost!.toPrecision(2),
            )
        );
      }

     dropDownValue = _bookingDetailsContent!.bookingStatus!;
    }else if(response.statusCode == 200 && response.body["response_code"] == "default_204") {
      _bookingDetailsModel = BookingDetailsModel.fromJson(response.body);
      _bookingDetailsContent = null;
    } else{
     ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> acceptBookingRequest(String bookingId) async {
    _isAcceptButtonLoading = true;
    update();
    Response response = await bookingDetailsRepo.acceptBookingRequest(bookingId);
    if(response.statusCode==200 && response.body['response_code'] == "status_update_success_200"){
      await getBookingDetailsData(_bookingDetailsContent!.id!,reload: false);
      showCustomSnackBar(response.body["message"],  type: ToasterMessageType.success);
      Get.find<BookingRequestController>().removeBookingItemFromList(bookingId, shouldUpdate: true, bookingStatus: "accepted");
    }
    else{
     ApiChecker.checkApi(response);
    }
    _isAcceptButtonLoading = false;
    update();
  }

  Future<void> changeSchedule() async {
    Response response = await bookingDetailsRepo.changeSchedule(bookingDetailsContent!.id!,_schedule);
    if(response.statusCode==200){
      getBookingDetailsData(_bookingDetailsContent!.id!,reload: false);
      showCustomSnackBar("service_schedule_changed_successfully".tr, type: ToasterMessageType.success);
    }
    else{
     ApiChecker.checkApi(response);
    }
  }


   Future<void> changeBookingStatus(String bookingId,{String? bookingStatus, bool isBack = false}) async {
    _isStatusUpdateLoading = true;
    update();

    List<MultipartBody> multiParts = [];
    for(XFile file in _photoEvidence) {
      multiParts.add(MultipartBody('evidence_photos[]', file));
    }

    if(bookingStatus != null && bookingStatus == 'ongoing' && dropDownValue == 'canceled'){
      showCustomSnackBar('service_ongoing_can_not_cancel_booking'.tr, type : ToasterMessageType.info);
    }else if(bookingStatus != null && bookingStatus == 'ongoing' && dropDownValue == 'accepted'){
      showCustomSnackBar('service_is_already_ongoing'.tr, type : ToasterMessageType.info);
    }else{
      Response response = await bookingDetailsRepo.changeBookingStatus( bookingId, dropDownValue, otp ,multiParts);
      if(response.statusCode==200 && response.body["response_code"]=="status_update_success_200"){
        await getBookingDetailsData(bookingId,reload: false);

        if(isBack){
          Get.back();
        }
        showCustomSnackBar(response.body['message'].toString().capitalizeFirst,  type: ToasterMessageType.success);
        Get.find<BookingRequestController>().removeBookingItemFromList(bookingId, shouldUpdate: true, bookingStatus: dropDownValue);

      }
      else if(response.statusCode==200 && response.body["response_code"] == "default_403"){
        if(dropDownValue == "completed" && otp.isNotEmpty){
          _isWrongOtpSubmitted  = true;
        }
      }else{
        ApiChecker.checkApi(response);
      }
    }
    _isStatusUpdateLoading = false;
    update();
  }

  Future<bool> sendBookingOTPNotification(String? bookingId, {bool shouldUpdate = true, bool resend = false}) async {
    if(shouldUpdate){
      _hideResendButton = true;
      update();
    }
    Response response = await bookingDetailsRepo.sendBookingOTPNotification(bookingId);
    bool isSuccess;
    if(response.statusCode == 200) {
      isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      isSuccess = false;
    }
    _hideResendButton = false;
    update();
    return isSuccess;
  }

  void updateServicePageCurrentState(BookingDetailsTabControllerState bookingDetailsTabControllerState, {bool shouldUpdate = true}){
    bookingPageCurrentState = bookingDetailsTabControllerState;
    if(shouldUpdate){
      update();
    }
  }


  void showHideExpandView(double bottomHeight, {bool shouldUpdate = true}){
    _isExpand = !_isExpand;
    _bottomSheetHeight = bottomHeight;

    if(shouldUpdate){
      update();
    }
  }

  void changeBookingStatusDropDownValue(String status){
    dropDownValue = status;
    update();
  }

  void changePhotoEvidenceStatus({bool isUpdate = true , bool status = false}){
    _showPhotoEvidenceField = status;
    if(isUpdate) {
      update();
    }
  }

  Future<void> pickPhotoEvidence({required bool isRemove, required bool isCamera}) async {
    if(isRemove) {
      _photoEvidence = [];
      _showPhotoEvidenceField = false;
    }else {
      XFile? xFile = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 50);
      if(xFile != null) {
        _photoEvidence.add(xFile);
        if(Get.isBottomSheetOpen!){
          Get.back();
        }
        changePhotoEvidenceStatus(isUpdate: false, status: true);
      }
      update();
    }
  }

  void removePhotoEvidence(int index) {
    _photoEvidence.removeAt(index);
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    resetWrongOtpValue(shouldUpdate: false);
    if(otp != '') {
      update();
    }
  }

  void resetWrongOtpValue({bool shouldUpdate = true}){
    _isWrongOtpSubmitted = false;

    if(shouldUpdate){
      update();
    }
  }


  bool isShowChattingButton(){
    return ( (_bookingDetailsContent != null) && (_bookingDetailsContent?.bookingStatus == "accepted" || _bookingDetailsContent?.bookingStatus == "ongoing" )
        && (bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails) && (_bookingDetailsContent!.serviceman !=null || _bookingDetailsContent!.customer != null));
  }
}