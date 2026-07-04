import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class BookingDetailsRepo{
  final ApiClient apiClient;

  BookingDetailsRepo({required this.apiClient});

  Future<Response> getBookingDetailsData(String bookingID) async {
    return await apiClient.getData("${AppConstants.bookingDetailsUrl}/$bookingID");
  }

  Future<Response> acceptBookingRequest(String bookingID) async {
    return await apiClient.putData("${AppConstants.acceptBookingRequestUrl}/$bookingID",{'method':'put'});
  }

  Future<Response> changeSchedule(String bookingID,String schedule) async {
    return await apiClient.putData("${AppConstants.changeScheduleUrl}/$bookingID",{'schedule': schedule});
  }

  Future<Response> changeBookingStatus(String bookingID,String status, String otp, List<MultipartBody>? photoEvidence) async {
    return await apiClient.postMultipartData(
        "${AppConstants.changeBookingStatusUrl}/$bookingID",{'booking_status':status,'_method':'put', "booking_otp": otp}, photoEvidence,null
    );
  }

  Future<Response> sendBookingOTPNotification(String? bookingId) {
    return apiClient.getData("${AppConstants.bookingOTPNotificationUri}?booking_id=$bookingId");
  }

  Future<Response> getBookingPriceList(String zoneId , String serviceInfo){
    return apiClient.getData("${AppConstants.getBookingPriceList}?zone_id=$zoneId&service_info=$serviceInfo");
  }

  Future<Response> removeCartServiceFromServer({CartModel? cart , String? bookingId, String? zoneId}){
    return apiClient.postData(AppConstants.removeCartServiceFromServer, {
      "_method" : "put",
      "booking_id" : bookingId,
      "zone_id" : zoneId,
      "variant_key" : cart?.variantKey,
      "service_id" : cart?.serviceId
    });
  }

  Future<Response> updateBooking({String? bookingId, String? zoneId, String? paymentStatus, String? servicemanId, String? bookingStatus, String? serviceSchedule, String? serviceInfo }){
    return apiClient.postData(AppConstants.updateBooking, {
      "_method" : "put",
      "booking_id" : bookingId,
      "zone_id" : zoneId,
      "payment_status" : paymentStatus,
      "serviceman_id" : servicemanId,
      "booking_status" : bookingStatus,
      "service_schedule" : serviceSchedule,
      "service_info" : serviceInfo
    });
  }
}