import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';



class BookingRequestController extends GetxController with GetSingleTickerProviderStateMixin implements GetxService {

  final BookingRequestRepo bookingRequestRepo;
  BookingRequestController({required this.bookingRequestRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _selectedIndex = 0;
  int get currentIndex =>_selectedIndex;

  int _apiHitCount = 0;

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  List <BookingRequestModel>? _bookingRequestList;
  List <BookingRequestModel>? get bookingRequestList=> _bookingRequestList;

  BookingCount? _bookingCount;
  BookingCount? get bookingCount => _bookingCount;

  AutoScrollController? menuScrollController;
  TabController? tabController;


  List<String> bookingRequestStatusList =["all","pending","accepted", "ongoing","completed","canceled"];
  String get bookingStatus => bookingRequestStatusList[_selectedIndex];

  final ScrollController scrollController = ScrollController();


  @override
  void onInit(){
    super.onInit();
    tabController = TabController(vsync: this, length: 6);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getBookingRequestList(bookingRequestStatusList[_selectedIndex],offset+1, paginationLoading: true);
        }
      }

    });
  }


  Future<void> getBookingRequestList(String requestType,int offset, {bool reload = false, int index = 0, bool isFirst = false,bool paginationLoading = false}) async {
    _offset = offset;
    _apiHitCount ++;
    if(reload){
      _bookingRequestList = null;
    }
    if(paginationLoading){
      _isLoading = true;
    }

    if(!isFirst){
      update();
    }
    Response response = await bookingRequestRepo.getBookingRequestData(requestType.toLowerCase(), offset);

    if(response.statusCode == 200){

      _bookingCount = BookingCount.fromJson(response.body['content']['bookings_count']);


      if(_offset == 1){
        _bookingRequestList = [];
        List<dynamic> bookingList = response.body['content']['bookings']['data'];
        for (var bookingRequest in bookingList) {
          bookingRequestList!.add(BookingRequestModel.fromJson(bookingRequest));
        }
      }else{
        List<dynamic> bookingList = response.body['content']['bookings']['data'];
        for (var bookingRequest in bookingList) {
          bookingRequestList!.add(BookingRequestModel.fromJson(bookingRequest));
        }
      }
      _pageSize = response.body['content']['bookings']['last_page'];
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


  void updateBookingRequestIndex(int index){
    _selectedIndex = index;
    tabController?.index = index;
    update();
  }

  removeBookingItemFromList(String bookingId,  {bool shouldUpdate = false, required String bookingStatus}){

    _bookingRequestList?.removeWhere((element) => element.id == bookingId);


    if(shouldUpdate){
      update();
    }
  }

}