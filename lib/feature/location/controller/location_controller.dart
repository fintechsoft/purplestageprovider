import 'dart:ui';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:purplestage_provider/feature/location/model/geocode_address_model.dart';
import 'package:purplestage_provider/feature/location/model/place_details_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


enum Address {service, billing }
enum AddressLabel {home, office, others }
class LocationController extends GetxController  implements GetxService{
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 0, headingAccuracy: 0);
  Position _pickPosition = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 0, headingAccuracy: 0);
  bool _loading = false;
  String _address = '';
  String _pickAddress = '';
  String? _selectedPlaceId;

  final bool _isLoading = false;
  bool _buttonDisabled = true;

  GoogleMapController? _mapController;
  List<PredictionModel> _predictionList = [];

  bool get buttonDisabled => _buttonDisabled;
  List<PredictionModel> get predictionList => _predictionList;
  bool get isLoading => _isLoading;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  String get address => _address;
  String get pickAddress => _pickAddress;
  GoogleMapController? get mapController => _mapController;

  Set<Marker> markers = HashSet<Marker>();
  Map<PolylineId, Polyline> polyLines = {};


  Future<void> getCurrentLocation(bool fromAddress, {GoogleMapController? mapController, LatLng? defaultLatLng, bool notify = true}) async {
    _loading = true;
    if(notify) {
      update();
    }
    Position myPosition;
    try {
      Geolocator.requestPermission();
      Position newLocalData = await Geolocator.getCurrentPosition();
      myPosition = newLocalData;
    }catch(e) {
      if(defaultLatLng != null){
        myPosition = Position(
          latitude:defaultLatLng.latitude,
          longitude:defaultLatLng.longitude,
          timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1,
            altitudeAccuracy: 0, headingAccuracy: 0
        );
      }else{
        myPosition = Position(
          latitude:  Get.find<SplashController>().configModel.content!.defaultLocation!.defaultLocation?.lat ?? 0.0,
          longitude: Get.find<SplashController>().configModel.content!.defaultLocation!.defaultLocation?.lon ?? 0.0,
          timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1,
            altitudeAccuracy: 0, headingAccuracy: 0
        );
      }
    }


    if(fromAddress) {
      _position = myPosition;
    }else {
      _pickPosition = myPosition;
    }
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 16),
      ));
    }
    String addressFromGeocode = await getAddressFromGeocode(const LatLng(90, 90));
    fromAddress ? _address = addressFromGeocode : _pickAddress = addressFromGeocode;

    _loading = false;
    update();

  }



  void updatePosition(CameraPosition position) async {
    _loading = true;
      update();
      try {
        _pickPosition = Position(
            latitude: position.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1,
            altitudeAccuracy: 0, headingAccuracy: 0
          );
        String addressFromGeocode = await getAddressFromGeocode(LatLng(position.target.latitude, position.target.longitude));
        _pickAddress = addressFromGeocode;
        Get.find<SignUpController>().setAddressControllerText(_pickAddress);
      } catch (e) {
        if (kDebugMode) {
          print('');
        }
      }

      _loading = false;
    update();
  }


  Future<void> setLocation(String placeID, String address, GoogleMapController? mapController) async {
    _loading = true;
    update();

    LatLng latLng = const LatLng(0, 0);
    _selectedPlaceId = placeID;
    Response response = await locationRepo.getPlaceDetails(placeID);
    if(response.statusCode == 200) {
      PlaceDetailsModel placeDetails = PlaceDetailsModel.fromJson(response.body);
      if(placeDetails.content!.status == 'OK') {
        latLng = LatLng(placeDetails.content!.result!.geometry!.location!.lat!, placeDetails.content!.result!.geometry!.location!.lng!);
      }
    }

    _pickPosition = Position(
      latitude: latLng.latitude, longitude: latLng.longitude,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1,
        altitudeAccuracy: 0, headingAccuracy: 0
    );

    _pickAddress = address;

    if(mapController != null){
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 17)));
    }
    _loading = false;
    update();
  }



  Future<void> setMapController(GoogleMapController mapController) async {
    _mapController = mapController;
    update();
  }

    Future<String> getAddressFromGeocode(LatLng latLng) async {
      Response response = await locationRepo.getAddressFromGeocode(latLng);
      String address = 'Unknown Location Found';
      if(response.statusCode == 200 && response.body['content']['status'] == 'OK') {

        List<GeoCodeAddressModel> addressList = [];
        List<dynamic> data = response.body['content']['results'];
        for (var element in data) {
          addressList.add(GeoCodeAddressModel.fromJson(element));
        }

        address = response.body['content']['results'][0]['formatted_address'].toString();
        for (var element in addressList) {

          if(element.placeId == _selectedPlaceId){
            address = element.formattedAddress ?? response.body['content']['results'][0]['formatted_address'].toString();
          }
        }
      }else {
        showCustomSnackBar(response.body['errors'][0]['message'] ?? response.bodyString.toString().tr);
      }
      return address;
    }

  Future<List<PredictionModel>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response.body['response_code'] == "default_200" && response.body['content']['status'] == 'OK') {
        _predictionList = [];
        response.body['content']['predictions'].forEach((prediction) => _predictionList.add(PredictionModel.fromJson(prediction)));
      } else {
      }
    }
    return _predictionList;
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }

  void disableButton() {
    _buttonDisabled = true;
    update();
  }

  void setPlaceMark(String address) {
    _address = address;
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _address = _pickAddress;
    update();
  }

  void resetPickedLocation({bool shouldUpdate = true}){
    _pickAddress ="";
    _pickPosition = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 0, headingAccuracy: 0);
    if(shouldUpdate){
      update();
    }
  }

  setSelectedPlaceId({String? placeId}){
    _selectedPlaceId = placeId;
  }
}


