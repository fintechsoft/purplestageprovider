import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';


class AddEventDialog extends StatelessWidget {
  const AddEventDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.close, size: 18))
            ),

            Image.asset(Images.addEventDialogIcon, height: 100, width: 100),
            const SizedBox(height: Dimensions.paddingSizeDefault),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Text(
                'add_event_dialog_title'.tr, textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Text(
                'add_event_dialog_description'.tr, textAlign: TextAlign.center,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),


            Row(children: [

              Expanded(child: Container()),

              Expanded(flex: 2,
                child: CustomButton(
                  btnTxt: 'create_ads'.tr,
                  onPressed: (){
                    Get.back();
                    Get.find<EventController>().resetAllValues();
                    Get.to(()=>const CreateEventScreen(isEditScreen: false));
                  },
                ),
              ),

              Expanded(child: Container()),

            ]),

          ]),
        ),
      ),
    );
  }
}
