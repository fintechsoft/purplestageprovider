import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:purplestage_provider/feature/profile/view/artistic_information/widgets/artistic_general_info.dart';

class ArtisticInformationScreen extends StatefulWidget {
  const ArtisticInformationScreen({super.key});
  @override
  State<ArtisticInformationScreen> createState() => _ArtisticInformationScreenState();
}
class _ArtisticInformationScreenState extends State<ArtisticInformationScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<UserProfileController>().getArtisticProviderInfo(reload:true);
   Get.find<UserProfileController>().resetArtisticImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: "Artistic Information"),
      body:  SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 1,
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
                        child: Text("Artistic Information"),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ArtisticGeneralInfo(),
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
