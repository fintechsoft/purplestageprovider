import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class EventController extends GetxController with GetSingleTickerProviderStateMixin implements GetxService {

  final EventRepo eventRepo;
  EventController({required this.eventRepo});

  int _selectedIndex = 0;
  int get currentIndex =>_selectedIndex;

  bool _isEditScreen = false;
  bool get isEditScreen => _isEditScreen;

  int _apiHitCount = 0;

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  List <EventData>? _eventDataList;
  List <EventData>? get eventDataList => _eventDataList;

  EventData? _eventData;
  EventData? get eventData => _eventData;

  final List<String> _eventType = ['cultural', "Fest","Academics","Placement drive","Welfare","Get together","Summit","Forum","Mela","Star Night","DJ night","Unofficial party","Other"];
  List<String> get eventType => _eventType;

  String _selectedEventType = "cultural";
  String get selectedEventType => _selectedEventType;

  AutoScrollController? menuScrollController;

  final GlobalKey<FormState> noteFormKey = GlobalKey<FormState>();

  bool isDateRangeValid = true;

  bool _isPosterImageValid = true;
  bool get isPosterImageValid => _isPosterImageValid;

  XFile? _pickedPosterImage;
  XFile? get pickedPosterImage => _pickedPosterImage;

  String? _networkPosterImage;
  String? get networkPosterImage => _networkPosterImage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  DateTime? eventdateTime;

  List<String> eventStatusList =["all","pending","approved","expired","rejected"];
  List<String> eventStatusImageList = [
    Images.allIcon,
    Images.pendingIcon,
    Images.approvedIcon,
    Images.expiredIcon,
    Images.deniedIcon
  ];
  String get eventStatus => eventStatusList[_selectedIndex];

  TextEditingController? validationController;
  TextEditingController? eventNameController;
  TextEditingController? institutionNameController;
  TextEditingController? contactNoController;
  TextEditingController? typeOfEventController;
  TextEditingController? eventTimeController;
  TextEditingController? venueController;
  TextEditingController? eventDescriptionController;
  TextEditingController? eventPosterController;
  TextEditingController? posterDescriptionController;
  String typeOfEvent = '';

  setEventType({required String type, bool shouldUpdate = true}){
    _selectedEventType = type;
    if(shouldUpdate){
      update();
    }
  }

  bool _isPaid = false;
  bool get isPaid => _isPaid;


  bool _isChecked = false;
  bool get isChecked => _isChecked;

  TabController? listTabController;

  bool _isVerified = false;
  bool get isVerified => _isVerified;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();

    listTabController = TabController(vsync: this, length: 5);

    validationController = TextEditingController();
    eventNameController = TextEditingController();
    institutionNameController = TextEditingController();
    contactNoController = TextEditingController();
    typeOfEventController = TextEditingController();
    eventTimeController = TextEditingController();
    venueController = TextEditingController();
    eventDescriptionController = TextEditingController();
    eventPosterController = TextEditingController();
    posterDescriptionController = TextEditingController();
    String typeOfEvent = '';
    bool isPaid = false;
    bool isChecked = false;
    bool isVerified = false;

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getEventList(eventStatus,offset+1, paginationLoading: true);
        }
      }
    });
  }

  @override
  void dispose(){
    eventNameController?.dispose();
    institutionNameController?.dispose();
    contactNoController?.dispose();
    venueController?.dispose();
    eventDescriptionController?.dispose();
    super.dispose();
  }

  void initializeEventValues (EventData eventData){
    resetAllValues();
    _networkPosterImage = eventData.eventPosterFullPath;
  }

  Future<void> setEventData(EventData eventdata)
  async {
    _eventData=eventdata;
  }

  Future<void> getEventList(String requestType, int offset, {bool reload = false, int index = 0, bool isFirst = false, bool paginationLoading = false}) async {
    _offset = offset;
    _apiHitCount ++;

    if(reload){
      _eventDataList = null;
    }
    if(paginationLoading){
      _isLoading = true;
    }
    if(!isFirst){
      update();
    }

    Response response = await eventRepo.getEventList(requestType: requestType.toLowerCase(), offset: offset);
    String ss= response.body['response_code'].toString();
    print("Listdata -- $ss");
    if(response.statusCode == 200 && response.body['response_code'] == 'default_200'){
      List<dynamic> eventList = response.body['content']['data'];
      String listcount = eventList.length.toString();
      print("List -- $listcount");
      if(_offset == 1){
        _eventDataList = [];
        for(var item in eventList){
          _eventDataList?.add (EventData.fromJson(item));
        }
      }else{
        for(var item in eventList){
          _eventDataList?.add (EventData.fromJson(item));
        }
      }
      _pageSize = response.body['content']['last_page'];
    }
    else{
     ApiChecker.checkApi(response);
    }
    _apiHitCount--;

    _isLoading = false;
    if(_apiHitCount==0){
      update();
    }
  }

  void updateEventTabIndex(int index, {bool shouldUpdate = true}){
    _selectedIndex = index;
    listTabController?.index=index;
    if(shouldUpdate){
      update();
    }
  }

  // Future<void> submitNewEvent ({List<TextEditingController>? titleController, List<TextEditingController>? descriptionController, List<Language>? languageList}) async{
  //   _isLoading = true;
  //   update();
  //
  //   List<MultipartBody> selectedFiles = [];
  //   if(selectedAdsType == 'profile_promotion'){
  //     selectedFiles.add(MultipartBody('profile_image', _pickedProfileImage!));
  //     selectedFiles.add(MultipartBody('cover_image', _pickedCoverImage!));
  //   }else{
  //     selectedFiles.add(MultipartBody('video_attachment',_pickedVideoFile!));
  //   }
  //
  //   Map<String, String> body = {
  //     'type': selectedAdsType,
  //     'start_date': DateConverter.dateTimeStringToDate(dateTimeRange?.start.toString() ?? ""),
  //     'end_date': DateConverter.dateTimeStringToDate(dateTimeRange?.end.toString() ?? ""),
  //     'review': isReviewChecked ? "1" : "0",
  //     'rating': isRatingsChecked ? "1" : "0",
  //   };
  //   for(int index = 0; index < titleController!.length ; index ++){
  //     body['title[$index]'] = titleController[index].text;
  //     body['description[$index]'] = descriptionController![index].text;
  //     body['lang[$index]'] = languageList![index].languageCode!;
  //   }
  //
  //   Response response = await eventRepo.submitNewEvent(body, selectedFiles);
  //   if(response.statusCode == 200 && response.body['response_code'] == 'default_store_200'){
  //     await getEventList("all", 1);
  //     _isLoading = false;
  //     updateEventTabIndex(0);
  //     update();
  //     Get.back();
  //     showCustomBottomSheet(child: const AdCreatedSuccessfullySheet());
  //   }else{
  //     _isLoading = false;
  //     update();
  //     showCustomSnackBar(response.body['errors'][0]['message']);
  //   }
  //
  // }

  Future<void> submitEvent({
    required TextEditingController eventNameController,
    required TextEditingController institutionNameController,
    required TextEditingController contactNoController,
    required String typeOfEventController,
    required TextEditingController eventDescriptionController,
    required TextEditingController posterDescriptionController,
    required TextEditingController venueController,
    required DateTime eventTime,
    required bool isPaid,
    XFile? eventPoster,
  }) async {
    // Set loading state
    _isLoading = true;
    update();
    List<MultipartBody> selectedFiles = [];
    if (eventPoster != null) {
      selectedFiles.add(MultipartBody('event_poster', eventPoster));
    }
    // Construct the body of the request using EventData fields
    Map<String, String> body = {
      'event_name': eventNameController.text,
      'institution_name': institutionNameController.text,
      'contact_no': contactNoController.text,
      'type_of_event': typeOfEventController,
      'event_time': eventTime.toIso8601String(),
      'venue': venueController.text,
      'event_description': eventDescriptionController.text,
      'poster_description': posterDescriptionController.text,
      'is_paid': isPaid ? '1' : '0',
    };
    // Submit the event data to the repository
    Response response = await eventRepo.submitNewEvent(body, selectedFiles);
    // Handle response success
    if (response.statusCode == 200 && response.body['response_code'] == 'default_store_200') {
      await getEventList("all", 1);
      _isLoading = false;
      update();
      Get.back();
      showCustomBottomSheet(child: const EventCreatedSuccessfullySheet());
    } else {
      // Handle response failure
      _isLoading = false;
      update();
      showCustomSnackBar(response.body['errors'][0]['message']);
    }
  }


  Future<void> editEvent (EventData eventData, {required bool isFromDetailsPage, required TextEditingController eventNameController,
    required TextEditingController institutionNameController,
    required TextEditingController contactNoController,
    required TextEditingController typeOfEventController,
    required TextEditingController eventDescriptionController,
    required TextEditingController posterDescriptionController,
    required TextEditingController venueController,
    required DateTime eventTime,
    required bool isPaid,
    XFile? eventPoster}) async {
    _isLoading = true;
    update();

    List<MultipartBody> selectedFiles = [];
    if(_pickedPosterImage != null){
      selectedFiles.add(MultipartBody('event_poster', _pickedPosterImage!));
    }

    Map<String, String> body = {
      'event_name': eventNameController.text,
      'institution_name': institutionNameController.text,
      'contact_no': contactNoController.text,
      'type_of_event': typeOfEventController.text,
      'event_time': eventTime.toIso8601String(),
      'venue': venueController.text,
      'event_description': eventDescriptionController.text,
      'is_paid': isPaid ? '1' : '0',
    };

    Response response = await eventRepo.editEvent(id: eventData.id!, body: body, selectedFile: selectedFiles);
    if(response.statusCode == 200 && response.body['response_code'] == 'default_update_200'){
      await getEventList(eventStatus, 1);
      if(isFromDetailsPage){
        Get.back();
      }
      Get.back();
      showCustomSnackBar(response.body['message'],  type: ToasterMessageType.success);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }


  // Future<void> getEventDetails ({required String id}) async {
  //   _eventDetailsModel = null;
  //   Response response = await eventRepo.getEventDetails(id: id);
  //   if(response.statusCode == 200 && response.body['response_code'] == 'default_200'){
  //     _eventDetailsModel = EventDetailsModel.fromJson(response.body);
  //   }else if (response.statusCode == 200 && response.body['response_code'] == 'default_204'){
  //     _eventDetailsModel = EventDetailsModel.fromJson(response.body);
  //     removeEventItemFromList(id, shouldUpdate: false);
  //   }else{
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  String setEventDateTime(){
    String eventDate = DateConverter.dateToDateAndTime(eventdateTime);
    return "$eventDate";
  }
  Future<void> deleteEvent ({required String id}) async {
    _isLoading = true;
    update();
    Response response = await eventRepo.deleteEvent(id: id);
    if(response.statusCode == 200 && response.body['response_code'] == 'default_delete_200'){
      await getEventList(eventStatus, 1);
      Get.back();
      showCustomSnackBar("${response.body['message']}", type: ToasterMessageType.success);
      eventDataList?.removeWhere((element) => element.id == id);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> reSubmitEvent
      (EventData eventData, {required TextEditingController eventNameController,
    required TextEditingController institutionNameController,
    required TextEditingController contactNoController,
    required TextEditingController typeOfEventController,
    required TextEditingController eventDescriptionController,
    required TextEditingController posterDescriptionController,
    required TextEditingController venueController,
    required DateTime eventTime,
    required bool isPaid,
    XFile? eventPoster}) async {
    _isLoading = true;
    update();

    List<MultipartBody> selectedFiles = [];
    if(_pickedPosterImage != null){
      selectedFiles.add(MultipartBody('event_poster', _pickedPosterImage!));
    }

    Map<String, String> body = {
      'event_name': eventNameController.text,
      'institution_name': institutionNameController.text,
      'contact_no': contactNoController.text,
      'type_of_event': typeOfEventController.text,
      'event_time': eventTime.toIso8601String(),
      'venue': venueController.text,
      'event_description': eventDescriptionController.text,
      'is_paid': isPaid ? '1' : '0',
    };
    Response response = await eventRepo.reSubmitEvent(eventData.id!, body: body, selectedFile: selectedFiles);
    if(response.statusCode == 200 && response.body['response_code'] == 'default_update_200'){
      await getEventList(eventStatus, 1);
      Get.back();
      showCustomSnackBar(response.body['message'],  type: ToasterMessageType.success);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();

  }

  removeEventItemFromList(String eventID,  {bool shouldUpdate = false}){
    _eventDataList?.removeWhere((element) => element.id == eventID);
    if(shouldUpdate){
      update();
    }
  }


  checkValidation (){
    if(_pickedPosterImage == null && _networkPosterImage == null){
      _isPosterImageValid = false;
    }else{
      _isPosterImageValid = true;
    }
    update();
  }


  void pickPosterImage(bool isRemove) async {
    if(isRemove){
      _pickedPosterImage =null;
      _networkPosterImage = null;
    }
    else{
      _pickedPosterImage =null;
      _pickedPosterImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      double imageSize = await ImageSize.getImageSizeFromXFile(_pickedPosterImage!);
      _isPosterImageValid = true;
      if(imageSize > AppConstants.maxSizeOfASingleFile){
        _pickedPosterImage =null;
        _isPosterImageValid = false;
        showCustomSnackBar("Poster Image Size Greater Than");
      }
    }
    update();
  }

  String getEventStatus(String? status, String eventDate) {
    DateTime networkEventDate = DateConverter.isoUtcStringToLocalDateevent(eventDate);
    DateTime currentDate = DateTime.now();
    if((status == "approved") && (currentDate.isAfter(networkEventDate))){
      return "running";
    }
    return status ?? "" ;
  }

  bool validateEventDateTime(){
    bool isBefore = false;
    if(eventTimeController?.text != null){
      String formattedString = validationController!.text.removeAllWhitespace;
      DateTime networkStartDate = DateFormat("ddMMM,yyyy").parse(formattedString).toLocal();
      DateTime todayDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      isBefore = networkStartDate.isBefore(todayDate);
    }
    return isBefore;
  }

  bool isEventExpired (String endDate) {
    DateTime dateWithTime = DateConverter.isoUtcStringToLocalDateOnly(endDate);
    DateTime endDateOnly = DateTime(dateWithTime.year, dateWithTime.month, dateWithTime.day);
    DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if(currentDate.isAfter(endDateOnly)){
      return true;
    }
    return false;
  }
  List<PopupMenuModel> getPopupMenuList(String status){
    if(status == "pending"){
      return [
        PopupMenuModel(title: "View Event", icon: Icons.remove_red_eye_sharp),
        PopupMenuModel(title: "Edit Event", icon: Icons.edit),
        PopupMenuModel(title: "Cancel Event", icon: Icons.close),
      ];
    } else if(status == "approved" || status == 'running'){
      return [
        PopupMenuModel(title: "View Event", icon: Icons.remove_red_eye_sharp),
        PopupMenuModel(title: "Edit Event", icon: Icons.edit),
        PopupMenuModel(title: "Delete Event", icon: Icons.delete),
      ];
    } else if (status == 'rejected'){
      return [
        PopupMenuModel(title: "View Event", icon: Icons.remove_red_eye_sharp),
        PopupMenuModel(title: "Edit Event", icon: Icons.edit),
        PopupMenuModel(title: "Delete Event", icon: Icons.delete),
      ];
    }
    return [];
  }

  setIsEditScreen({required bool isEditScreen, bool shouldUpdate = false}){
    _isEditScreen = isEditScreen;
    if(shouldUpdate){
      update();
    }
  }
  resetAllValues ({bool shouldUpdate = false}){
    _isEditScreen = false;
    _isChecked = false;
    _isPosterImageValid = true;
    _isPaid=true;
    _isVerified=true;

    _pickedPosterImage = null;
    validationController?.text = '';
    eventNameController!.text = '';
    institutionNameController!.text = '';
    contactNoController!.text = '';
    typeOfEventController!.text = '';
    eventDescriptionController!.text = '';
    venueController!.text = '';

    _networkPosterImage = null;
    eventdateTime = null;

    if(shouldUpdate){
      update();
    }
  }
}