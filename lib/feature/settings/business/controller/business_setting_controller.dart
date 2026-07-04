import 'dart:convert';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class BusinessSettingController extends GetxController implements GetxService{
  final BusinessSettingRepo businessSettingRepo;
  BusinessSettingController({required this.businessSettingRepo});

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  List<BusinessSettings> _settingItem = [];
  List<BusinessSettings> get settingItem  => _settingItem;

  List<String> daysList = ['saturday', "sunday", "monday", "tuesday", "wednesday", "thursday", "friday"];
  List<bool> daysCheckList =[false, false, false, false, false, false, false];

  bool _serviceAvailabilitySettings = false;
  bool get serviceAvailabilitySettings => _serviceAvailabilitySettings;


  String? _serviceStartTime ;
  String? get serviceStartTime => _serviceStartTime;
  set setServiceStartTime(String? time) => _serviceStartTime = time;


  String? _serviceEndTime;
  String? get serviceEndTime => _serviceEndTime;
  set setServiceEndTime(String? time) => _serviceEndTime = time;

  BookingSettingResponseModel? _bookingSettingResponseModel;
  ServiceAvailabilityModel? _serviceAvailabilitySettingResponseModel;

  List<String> settings = [
    "provider_serviceman_can_cancel_booking",
    "provider_serviceman_can_edit_booking"
  ];

  Future<void> getBookingSettingsDataFromServer() async {
    Response response =  await businessSettingRepo.getBookingSettingsFromServer(settings);

    if(response.statusCode == 200 ){
      _settingItem = [];
      _bookingSettingResponseModel = BookingSettingResponseModel.fromJson(response.body);
      if(_bookingSettingResponseModel?.settingsList != null && _bookingSettingResponseModel!.settingsList!.isNotEmpty){
        _bookingSettingResponseModel?.settingsList?.forEach((element) {
          _settingItem.add(BusinessSettings(
            settingTitle: element.keyName?.replaceAll("provider_",""),
            settingsValue: element.mode == "live" ? element.liveValues ?? 0 : element.testValues ?? 0,
            toolTipText: element.keyName!.contains("provider_serviceman_can_cancel_booking") ? "serviceman_booking_cancel_hint": "serviceman_can_edit_booking_hint",
            toolTipController: JustTheController(),
            keyValue: element.keyName,
          ));
        });
      } else{
        for (var element in settings) {
          _settingItem.add(BusinessSettings(
            settingTitle: element.replaceAll("provider_",""),
            settingsValue: 0,
            toolTipText: element.replaceAll("provider_",""),
            toolTipController: JustTheController(),
            keyValue: element,
          ));
        }
      }
    }else{

    }
   // update();
  }


  Future<void> getServiceAvailabilitySettingsFromServer() async {
    Response response =  await businessSettingRepo.getServiceAvailabilitySettingsFromServer();

    if(response.statusCode == 200 && response.body["response_code"] == "default_200"){
      _serviceAvailabilitySettingResponseModel = ServiceAvailabilityModel.fromJson(response.body);
      _serviceAvailabilitySettings = _serviceAvailabilitySettingResponseModel?.content?.serviceAvailability == 1 ? true : false;
      _serviceStartTime = DateConverter.dateTimeStringToDateOnly(_serviceAvailabilitySettingResponseModel?.content?.timeSchedule?.startTime ?? '00:00');
      _serviceEndTime = DateConverter.dateTimeStringToDateOnly(_serviceAvailabilitySettingResponseModel?.content?.timeSchedule?.endTime ?? '00:00');

      for (int i =0 ; i < 7 ; i++) {
        _serviceAvailabilitySettingResponseModel?.content?.weekends?.forEach((element) {
          if(daysList[i] == element){
            daysCheckList[i] = true;
          }
        });
      }

    }else{

    }
    // update();
  }





  Future<void> updateBookingSettingsIntoServer() async {

    List< Map<String, String>> settingsData = [];

    for(int i = 0; i < _settingItem.length; i ++ ){
      settingsData.add({
        "key" : _settingItem[i].keyValue!,
        "value" : _settingItem[i].settingsValue.toString()
      });
    }
    _isLoading = true;
    update();
    Response response =  await businessSettingRepo.updateBookingSettingIntoServer(jsonEncode(settingsData));
    if(response.statusCode == 200 && response.body['response_code'] == "default_update_200"){
      showCustomSnackBar("successfully_updated".tr,  type: ToasterMessageType.success);
    }else{
      showCustomSnackBar(response.body["message"] ?? "");
    }
    _isLoading = false;
    update();
  }


  Future<void> updateServiceAvailabilitySettingsIntoServer() async {

    List<String> weekends = [];

    for(int i = 0 ; i< daysCheckList.length ; i++){
      if(daysCheckList[i] == true){
        weekends.add(daysList[i]);
      }
    }

    Map<String, dynamic> settingsData = {
      "_method" : "put",
      "service_availability" : _serviceAvailabilitySettings ? "1" : "0",
      "start_time" : DateConverter.convertStringDateTo24HourFormat(_serviceStartTime ?? "00:00"),
      "end_time" : DateConverter.convertStringDateTo24HourFormat(_serviceEndTime ?? "00:00"),
      "weekends": weekends
    };


    _isLoading = true;
    update();
    Response response =  await businessSettingRepo.updateServiceAvailabilitySettingIntoServer(settingsData);
    if(response.statusCode == 200 && response.body['response_code'] == "default_update_200"){
      showCustomSnackBar("successfully_updated".tr,  type: ToasterMessageType.success);
      Get.find<UserProfileController>().getProviderInfo(reload: true);
    }else if(response.statusCode == 400 && response.body['response_code'] == "default_400") {

      if(response.body['errors']!=null){
        showCustomSnackBar(response.body["errors"][0]['message'] ?? "");
      }
    }else{
      showCustomSnackBar(response.body["message"] ?? "");
    }
    _isLoading = false;
    update();
  }


  void toggleSettingsValue(int index, int value){
    _settingItem[index].settingsValue = value;
    update();
  }

  void toggleDaysCheckedValue(int index) {

    daysCheckList[index] = !daysCheckList[index];
    update();

  }


  void toggleServiceAvailabilitySettings() {
    _serviceAvailabilitySettings = !serviceAvailabilitySettings;
    update();

  }


}