import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:purplestage_provider/feature/profile/model/provider_model.dart';
import 'package:purplestage_provider/feature/profile/model/artistic_model.dart';



class UserProfileController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserProfileController({required this.userRepo});

  final GlobalKey<FormState> profileInformationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> artisticInformationFormKey = GlobalKey<FormState>();

  TextEditingController? companyNameController,companyPhoneController,companyAddressController,companyEmailController,
      personalNameController,personalPhoneController,personalEmailController,
      emailController, passwordController,confirmPasswordController,
      cNameController,cPhoneController, personNameController,bioController,achievementsController,categorynameController,
      sociallink1Controller,sociallink2Controller,sociallink3Controller,otherdeliverableController, serviceOtherController, cashOtherController, benefitsOtherController;

  final List<String> _categorylist = ["Music/Singer","Dance","Fashion","Photography","Academics","Drama","Influencer","Placement","Entrepreneurship","Comedian","DJ","Event Organiser","Welfare","Other"];
  List<String> get categorylist => _categorylist;

  bool keepPersonalInfoAsCompanyInfo = false;

  bool _showOverflowDialog = false;
  bool get showOverflowDialog => _showOverflowDialog;

  bool _trialWidgetNotShow = false;
  bool get trialWidgetNotShow => _trialWidgetNotShow;

  String _providerId = '';
  String get providerId =>_providerId;

  var countryDialCode = "+91";

  String _selectedZoneID ='';
  String get selectedZoneID => _selectedZoneID;

  String _selectedZoneName ="";
  String get selectedZoneName => _selectedZoneName;

  String _selectedCategory = "Music / Singer";
  String get selectedCategory => _selectedCategory;

  String myZone='';
  String? myZoneId;
  String latitude='0';
  String longitude='0';

  List<ZoneData> zoneList=[];

  bool _isZoneValid = true;
  bool get isZoneValid => _isZoneValid;


  int _totalCompleteRequest= 0;
  int _totalCanceledRequest= 0;
  int _totalOngoingRequest= 0;
  int _totalAcceptedRequest= 0;

  int get totalCompletedRequest=> _totalCompleteRequest;
  int get totalCanceledRequest=> _totalCanceledRequest;
  int get totalOngoingRequest=> _totalOngoingRequest;
  int get totalAcceptedRequest=> _totalAcceptedRequest;


  List<String> selectedServices = [];
  final List<String> _promotionOptions = [
    'Confirmed no. of online followers',
    'Confirmed no. of online posts/stories with tag',
    'Kiosk',
    'Seminar',
    'App download',
    'Google reviews and rating',
    'Offline banners',
    'Offline footfall',
    'Other'
  ];
  List<String> get promotionOptions => _promotionOptions;


  String _selectedHonorarium = '';
  String get selectedHonorarium =>_selectedHonorarium;
// Setter for selectedHonorarium
  set selectedHonorarium(String? value) {
    _selectedHonorarium = value??'';
  }
  final List<String> cashOptions = [
    '0- 0.5k',
    '0.5- 1k',
    '1-3k',
    '3-5k',
    '5-10k',
    '10-15k',
    '15-20k',
    '20k+',
    'Other'
  ];
  List<String> selectedBenefits = [];
  final List<String> benefitsOptions = [
    'Coupons',
    'Hampers',
    'Gifts',
    'Vouchers',
    'Certificates',
    'Other'
  ];

  @override
  void onInit() {
    super.onInit();
    //getProviderInfo();
    companyNameController = TextEditingController();
    companyPhoneController = TextEditingController();
    companyAddressController = TextEditingController();
    companyEmailController = TextEditingController();

    personalNameController = TextEditingController();
    personalPhoneController = TextEditingController();
    personalEmailController = TextEditingController();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    cNameController = TextEditingController();
    cPhoneController= TextEditingController();
    personNameController= TextEditingController();
    bioController= TextEditingController();
    achievementsController= TextEditingController();
    categorynameController= TextEditingController();
    sociallink1Controller= TextEditingController();
    sociallink2Controller= TextEditingController();
    sociallink3Controller = TextEditingController();
    otherdeliverableController = TextEditingController();
    serviceOtherController = TextEditingController();
    cashOtherController = TextEditingController();
    benefitsOtherController = TextEditingController();

    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content?.countryCode??"IN").dialCode!;
  }

  @override
  void onClose() {
    companyNameController!.dispose();
    companyPhoneController!.dispose();
    companyAddressController!.dispose();
    companyEmailController!.dispose();
    personalNameController!.dispose();
    personalPhoneController!.dispose();
    personalEmailController!.dispose();

    emailController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();

    cNameController!.dispose();
    cPhoneController!.dispose();
    personNameController!.dispose();
    bioController!.dispose();
    achievementsController!.dispose();
    categorynameController!.dispose();
    sociallink1Controller!.dispose();
    sociallink2Controller!.dispose();
    sociallink3Controller !.dispose();
  }


  void togglePersonalInfoAsCompanyInfo(){
    keepPersonalInfoAsCompanyInfo =! keepPersonalInfoAsCompanyInfo;

    if(keepPersonalInfoAsCompanyInfo){
      personalNameController!.text = companyNameController!.text;
      personalPhoneController!.text = companyPhoneController!.text;
      personalEmailController!.text = companyEmailController!.text;
    }
    else{
        personalNameController!.text = _providerModel?.content?.providerInfo?.contactPersonName??"";
        personalPhoneController!.text = _providerModel?.content?.providerInfo?.contactPersonPhone??"";
        personalEmailController!.text= _providerModel?.content?.providerInfo?.contactPersonEmail??"";
    }
    update();
  }

  ProviderModel? _providerModel;
  ProviderModel? get providerModel => _providerModel;

  ArtisticModel? _artisticModel;
  ArtisticModel? get artisticModel => _artisticModel;

   XFile? _pickedFile ;
  XFile? _artisticpickedFile;
   bool _isLoading = false;


  XFile? get pickedFile => _pickedFile;
  XFile? get artisticpickedFile => _artisticpickedFile;
  bool get isLoading => _isLoading;

  Future<bool> getProviderInfo({reload = false}) async {

    Get.find<LocationController>().resetPickedLocation();


    if(_providerModel==null || reload){
      Response response = await userRepo.getProviderInfo();
      if (response.statusCode == 200) {
         getZoneList();
        _providerModel = ProviderModel.fromJson(response.body);

         double payablePercentage = getOverflowPercent(
           double.tryParse(_providerModel?.content?.providerInfo?.owner?.account?.accountPayable??"0")??0,
           double.tryParse(_providerModel?.content?.providerInfo?.owner?.account?.accountReceivable??"0")??0,
             Get.find<SplashController>().configModel.content?.maxCashInHandLimit ?? 0,
         );

         hideOverflowDialog(payablePercentage: payablePercentage, hideDialog: false);

        companyNameController!.text = _providerModel?.content?.providerInfo?.companyName??'';

        countryDialCode = ValidationHelper.getValidCountryCode(_providerModel?.content?.providerInfo?.companyPhone ?? "" ) != "" ? ValidationHelper.getValidCountryCode(_providerModel?.content?.providerInfo?.companyPhone ?? "") : CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode ?? "+880";
        companyPhoneController!.text = ValidationHelper.getValidPhone(_providerModel?.content?.providerInfo?.companyPhone ?? "") != "" ? ValidationHelper.getValidPhone(_providerModel?.content?.providerInfo?.companyPhone??"" ) : _providerModel?.content?.providerInfo?.companyPhone ?? "";

        companyAddressController!.text = _providerModel?.content?.providerInfo?.companyAddress??"";
        companyEmailController!.text = _providerModel?.content?.providerInfo?.companyEmail??"";
        personalNameController!.text = _providerModel?.content?.providerInfo?.contactPersonName??"";
        personalPhoneController!.text = ValidationHelper.getValidPhone(_providerModel?.content?.providerInfo?.contactPersonPhone ?? "") != "" ? ValidationHelper.getValidPhone(_providerModel?.content?.providerInfo?.contactPersonPhone??"" ) : _providerModel?.content?.providerInfo?.contactPersonPhone ?? "";
        personalEmailController!.text = _providerModel?.content?.providerInfo?.contactPersonEmail??"";
        emailController!.text = _providerModel?.content?.providerInfo?.owner?.email??"";
        latitude = _providerModel?.content?.providerInfo?.coordinates?.latitude??"0";
        longitude = _providerModel?.content?.providerInfo?.coordinates?.longitude??"0";
        _totalCompleteRequest= 0;
        _totalCanceledRequest= 0;
        _totalOngoingRequest= 0;
        _totalAcceptedRequest= 0;

        _providerId = _providerModel!.content!.providerInfo!.id!;
        myZoneId =_providerModel!.content!.providerInfo!.zoneId!;
        _selectedZoneID = myZoneId!;
        _selectedZoneName ='';

         getZoneList();

        if(companyNameController!.text==personalNameController!.text
            && companyPhoneController!.text==personalPhoneController!.text
            &&companyEmailController!.text==personalEmailController!.text){
          keepPersonalInfoAsCompanyInfo = true;
        }else{
          keepPersonalInfoAsCompanyInfo = false;
        }

        if(_providerModel!.content!.bookingOverview!=[] && _providerModel!.content!.bookingOverview!=null){
          for (var element in _providerModel!.content!.bookingOverview!) {
            if(element.bookingStatus=='accepted'){
              _totalAcceptedRequest = element.total!;
            }else if(element.bookingStatus=="canceled"){
              _totalCanceledRequest = element.total!;
            }else if(element.bookingStatus=="completed"){
              _totalCompleteRequest = element.total!;
            }else if(element.bookingStatus=="ongoing"){
              _totalOngoingRequest = element.total!;
            }
          }
        }else{
          _totalCompleteRequest= 0;
          _totalCanceledRequest= 0;
          _totalOngoingRequest= 0;
          _totalAcceptedRequest= 0;
        }
        _isLoading= false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;
    update();

    return _providerModel != null;

  }
  Future<bool> getArtisticProviderInfo({reload = false}) async {
    if(_artisticModel==null || reload){
      Response response = await userRepo.getArtisticProviderInfo();
      debugPrint("body--"+response.body.toString());
      if (response.statusCode == 200) {
        _artisticModel = ArtisticModel.fromJson(response.body);
        cNameController!.text = _artisticModel?.artisticinfo?.cName??'';
        countryDialCode = ValidationHelper.getValidCountryCode(_artisticModel?.artisticinfo?.cPhone ?? "" ) != "" ? ValidationHelper.getValidCountryCode(_artisticModel?.artisticinfo?.cPhone ?? "") : CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode ?? "+91";
        cPhoneController!.text = ValidationHelper.getValidPhone(_artisticModel?.artisticinfo?.cPhone ?? "") != "" ? ValidationHelper.getValidPhone(_artisticModel?.artisticinfo?.cPhone??"" ) : _artisticModel?.artisticinfo?.cPhone ?? "";
        personNameController!.text = _artisticModel?.artisticinfo?.rpName??'';
        bioController!.text = _artisticModel?.artisticinfo?.bio??'';
        achievementsController!.text = _artisticModel?.artisticinfo?.achievements??'';
        categorynameController!.text = _artisticModel?.artisticinfo?.categoryName??'';
        sociallink1Controller!.text = _artisticModel?.artisticinfo?.socialId1??'';
        sociallink2Controller!.text = _artisticModel?.artisticinfo?.socialId2??'';
        sociallink3Controller!.text = _artisticModel?.artisticinfo?.socialId3??'';
        selectedServices.addAll(_artisticModel?.artisticinfo?.promoServices??[]);
        selectedHonorarium!=_artisticModel?.artisticinfo?.cashHonorarium??'';
        bioController!.text = _artisticModel?.artisticinfo?.bio??'';
        selectedBenefits.addAll(_artisticModel?.artisticinfo?.benefitsInKind??[]);
        _isLoading= false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;
    update();

    return _artisticModel != null;

  }

  Future<ResponseModel> updateArtistic() async {
    _isLoading = true;
    update();

    Response response = await userRepo.updateArtistic(
        cNameController!.text.toString(),
        personNameController!.text.toString(),
        "$countryDialCode${ cPhoneController!.text.toString()}",
       selectedCategory,
        sociallink1Controller!.text.toString(),
        sociallink2Controller!.text.toString(),
        sociallink3Controller!.text.toString(),
        bioController!.text.toString(),
        achievementsController!.text.toString(),
        selectedServices,
        otherdeliverableController!.text.toString(),
        selectedHonorarium!,
        selectedBenefits,
        _artisticpickedFile
    );
    if(response.statusCode==200){

      if(companyNameController!.text==personalNameController!.text
          && companyPhoneController!.text==personalPhoneController!.text
          &&companyEmailController!.text==personalEmailController!.text){
        keepPersonalInfoAsCompanyInfo = true;
      }else{
        keepPersonalInfoAsCompanyInfo = false;
      }
      _isLoading=false;
      update();
      return ResponseModel(true, response.body['message']);
    }
    else{
      _isLoading = false;
      update();
      return  ResponseModel(false, response.body['errors'][0]['message']);
    }
  }

  Future<ResponseModel> updateProfile() async {
    _isLoading = true;
    update();

    if(Get.find<LocationController>().pickAddress!=""){
      latitude = Get.find<LocationController>().pickPosition.latitude.toString();
      longitude = Get.find<LocationController>().pickPosition.longitude.toString();
    }


    Response response = await userRepo.updateProfile(
        companyNameController!.text.toString(),
        "$countryDialCode${companyPhoneController!.text.toString()}",
        companyAddressController!.text.toString(),
        latitude,
        longitude,
        companyEmailController!.text.toString(),
        personalNameController!.text.toString(),
        "$countryDialCode${ personalPhoneController!.text.toString()}",
        personalEmailController!.text.toString(),
        _selectedZoneID,
        _pickedFile
    );
    if(response.statusCode==200){

      if(companyNameController!.text==personalNameController!.text
          && companyPhoneController!.text==personalPhoneController!.text
          &&companyEmailController!.text==personalEmailController!.text){
        keepPersonalInfoAsCompanyInfo = true;
      }else{
        keepPersonalInfoAsCompanyInfo = false;
      }
      _isLoading=false;
      update();
     return ResponseModel(true, response.body['message']);
    }
    else{
      _isLoading = false;
      update();
     return  ResponseModel(false, response.body['errors'][0]['message']);
    }
  }

  Future<ResponseModel> updateProfileWithPassword() async {
    _isLoading = true;
    update();

    Response response = await userRepo.updateProfileWithPassword(
      companyNameController!.text.toString(),
      companyPhoneController!.text.toString(),
      companyAddressController!.text.toString(),
      companyEmailController!.text.toString(),
      personalNameController!.text.toString(),
      personalPhoneController!.text.toString(),
      personalEmailController!.text.toString(),
      passwordController!.text,
      confirmPasswordController!.text,
      _selectedZoneID,
      latitude,
      longitude
    );

    if(response.statusCode==200){
      _isLoading=false;
      update();
      return  ResponseModel(true, response.body['message']);

    }
    else{
      _isLoading = false;
      update();
      return  ResponseModel(false, response.body['errors'][0]['message']);
    }
  }

  Future<void> getZoneList() async {
    _selectedZoneName ='';

    if(zoneList.isEmpty){
      Response? response = await userRepo.getZonesDataList();
      if (response!.statusCode == 200)
      {
        zoneList=[];

        List<dynamic>? list = response.body['content']['data'];

        if(zoneList.isEmpty){
          for (var element in list!) {
            zoneList.add(ZoneData.fromJson(element));
          }
        }

        if(zoneList.isNotEmpty && _providerModel!=null){

          for (var element in zoneList) {
            if(element.id==_providerModel!.content!.providerInfo!.zoneId!){
              myZone = element.name!;
            }
          }
        }
      }
      else {
      }
    }else{
      if(_providerModel!=null){
        for (var element in zoneList) {
          if(element.id==_providerModel!.content!.providerInfo!.zoneId!){
            myZone = element.name!;
          }
        }
      }
    }

      update();
  }

  void setNewZoneValue(String zoneName,zoneId){
    _selectedZoneName =zoneName;
    _selectedZoneID = zoneId;
    update();
  }

  void setselectedCategory(String CategoryName){
    _selectedCategory = CategoryName;
    update();
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery));
    update();
  }

  void pickArtistic() async {
    _artisticpickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery));
    update();
  }

  void resetImage() async {
    _pickedFile = null;
  }

  void resetArtisticImage() async {
    _artisticpickedFile = null;
  }

  double getOverflowPercent(double payable, double receivable, double maxAmount) {
     double amount = getTransactionAmountAmount(payable, receivable);

     double percentage = (amount / maxAmount) * 100;
     return percentage;
   }

  double getTransactionAmountAmount(double payable, double receivable) {
    double amount = 0;
    if(payable > receivable){
      amount = payable - receivable;
    }else{
      amount = receivable - payable;
    }
    return amount;
  }

  TransactionType getTransactionType (double payable, double receivable){
    TransactionType type =  TransactionType.none;

    if(payable == receivable){
      if(payable == 0 || receivable == 0){
        type  = TransactionType.none;
      }else{
        type = TransactionType.adjust;
      }
    } else if(payable > receivable ){
      if(receivable > 0.0){
        type = TransactionType.adjustAndPayable;
      }else{
        type = TransactionType.payable;
      }
    }else if(receivable > payable){
      if( payable> 0.0){
        type = TransactionType.adjustWithdrawAble;
      }else{
        type = TransactionType.withdrawAble;
      }
    } else{
      type  = TransactionType.none;
    }

    return type;
  }

  int numberOfShowDialog = 0;

  hideOverflowDialog({double? payablePercentage, bool hideDialog = true}){

    if(!hideDialog ){

      if(payablePercentage != null){
        if( !_showOverflowDialog && payablePercentage >= 80 && payablePercentage < 100 && numberOfShowDialog < 1){
          numberOfShowDialog ++;
          _showOverflowDialog = true;

        } else if(payablePercentage >= 100){
          numberOfShowDialog = 0;
          _showOverflowDialog = true;
        } else{
          // //numberOfShowDialog = 0;
          // _showOverflowDialog = false;
        }
      }

    }else{
      _showOverflowDialog = false;
      update();
    }
  }

  updateNumberOfTimeShowingDialog(){
    numberOfShowDialog = 0;
    _showOverflowDialog = false;
  }

  bool haveAnyAcceptedAndOngoingBooking(){
    return  (_totalAcceptedRequest + _totalOngoingRequest) > 0;
  }


  onProfileChangeValidationCheck({bool shouldUpdate = true}){
    if(selectedZoneName == ""){
      _isZoneValid = false;
    }
    if(shouldUpdate){
      update();
    }
  }

  void clearUserProfileData(){
    _providerModel  = null;
    update();
  }


  Future<bool> trialWidgetShow({required String route}) async {
    const Set<String> routesToHideWidget = {
      '/business-plan', 'show-dialog', '/success', '/payment',
    };
    _trialWidgetNotShow = routesToHideWidget.contains(route);

    Future.delayed(const Duration(milliseconds: 500), () {
      update();
    });
    return _trialWidgetNotShow;
  }


  bool checkAvailableFeatureInSubscriptionPlan({required String featureType}){

    bool status = _providerModel?.content?.subscriptionInfo?.status == "subscription_base"
        && !_providerModel!.content!.subscriptionInfo!.subscribedPackageDetails!.featureList!.contains(featureType) ? false : true;

    if(!status){
      showCustomSnackBar('this_feature_is_not_included_in_your_current_subscription_plan'.tr);
    }
    return status;
  }

}