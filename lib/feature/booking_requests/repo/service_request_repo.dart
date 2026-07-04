import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class BookingRequestRepo{
  final ApiClient apiClient;

  BookingRequestRepo({required this.apiClient});

  Future<Response> getBookingRequestData(String requestType, int offset) async {
    return await apiClient.postData(AppConstants.bookingListUrl,
        {"limit" : 10, "offset" : offset, "booking_status" : requestType});
  }
}