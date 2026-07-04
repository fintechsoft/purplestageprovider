import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class EventConfirmationBottomSheet extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String status;
  final Color? yesTestColor;
  final bool isShowNotNowButton;
  final Function() yesButtonPressed;
  final String? confirmButtonText;
  const EventConfirmationBottomSheet({super.key, this.confirmButtonText, this.isShowNotNowButton = true, required this.image, required this.title, required this.description, required this.yesButtonPressed, required this.status, this.yesTestColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(Dimensions.radiusDefault),
          topLeft: Radius.circular(Dimensions.radiusDefault)
        )
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: GetBuilder<EventController>(
        builder: (eventController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(image, height: 100, width: 100),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Text(title.tr, textAlign: TextAlign.center, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Text(description.tr, textAlign: TextAlign.center, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor))),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Row(children: [
              isShowNotNowButton ? Expanded(flex: 2, child: CustomButton(
                btnTxt: "not_now".tr,
                onPressed: (){
                  if(!eventController.isLoading){
                    Get.back();
                  }
                },
                color: Theme.of(context).hintColor.withOpacity(0.2),
                textColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
              )): const SizedBox(),
              const SizedBox(width: Dimensions.paddingSizeDefault),
              Expanded(flex: 2, child: CustomButton(
                  isLoading : eventController.isLoading,
                  btnTxt: confirmButtonText?.tr ?? "yes".tr,
                  onPressed: !eventController.isLoading? yesButtonPressed : (){},
                  color: yesTestColor ?? Theme.of(context).colorScheme.error
              )),
            ]),

            //SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ]);
        }
      ),
    );
  }
}
