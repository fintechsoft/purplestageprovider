import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class EventRepo {
  final ApiClient apiClient;
  EventRepo({required this.apiClient});

  Future<Response> submitNewEvent(Map<String, String> body, List<MultipartBody> selectedFile) async {
    return await apiClient.postMultipartData(
        AppConstants.submitNewEvent,
        body,
        selectedFile , null,
    );
  }


  Future<Response> editEvent ({required String id, required Map<String, String> body, List<MultipartBody>? selectedFile}) async {
    return await apiClient.postMultipartData(
      "${AppConstants.editEvent}/$id",
      body,
      selectedFile , null,
    );
  }


  
  Future<Response> getEventList ({required String requestType, required int offset}) async {
    return await apiClient.getData(
        "${AppConstants.getEventList}?limit=10&offset=$offset&booking_status=$requestType");
  }
  
  

  Future<Response> getEventDetails ({required String id}) async {
    return await apiClient.getData("${AppConstants.getEventDetails}/$id");
  }


  Future<Response> deleteEvent ({required String id}) async {
    return await apiClient.deleteData("${AppConstants.deleteEvent}/$id");
  }


  Future<Response> changeEventStatus ({required String id, required String status, required Map<String, String> body }) async {
    return await apiClient.putData(
      '${AppConstants.changeEventStatus}/$id/$status', body
    );
  }


  Future<Response> reSubmitEvent (String id,
      {required Map<String, String> body, required List<MultipartBody> selectedFile}) async {
    return await apiClient.postMultipartData(
      "${AppConstants.reSubmitEvent}/$id",
      body,
      selectedFile , null,
    );
  }


  
}