import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:purplestage_provider/feature/profile/view/profile_information/widgets/general_info.dart';
import 'package:purplestage_provider/feature/profile/view/profile_information/widgets/account_info.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});
  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}
class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  @override
  void initState() {
    super.initState();
   Get.find<UserProfileController>().getProviderInfo(reload: true);
   Get.find<UserProfileController>().resetImage();
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<UserProfileController>().passwordController?.clear();
    Get.find<UserProfileController>().confirmPasswordController?.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: "profile_information".tr),
      body:  SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
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
                  labelColor: Theme.of(context).primaryColorLight,
                  labelStyle:  ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                  labelPadding: EdgeInsets.zero,
                  tabs:  [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.45,
                      child:Center(
                        child: Text("general_info".tr),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.45,
                      child:  Center(
                        child: Text("account_info".tr),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    GeneralInfo(),
                    AccountInfo()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
