import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class BookingSetupWidget extends StatelessWidget {
  const BookingSetupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessSettingController>(builder: ( businessSettingController){
      return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context, index){
                return SwitchButton(
                  titleText: businessSettingController.settingItem[index].settingTitle!,
                  value: businessSettingController.settingItem[index].settingsValue!,
                  onTap: (bool value) {
                    businessSettingController.toggleSettingsValue(index , value == true ? 1 : 0);
                  },
                  tooltipController: businessSettingController.settingItem[index].toolTipController!,
                  tootTipText: businessSettingController.settingItem[index].toolTipText!,
                );},
                itemCount: businessSettingController.settingItem.length,
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault,),

            CustomButton(btnTxt: "update_settings".tr,
              onPressed: ()=> businessSettingController.updateBookingSettingsIntoServer(),
              isLoading: businessSettingController.isLoading,
            )
          ],
        ),
      );
    });
  }
}
