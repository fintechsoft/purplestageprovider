import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class NonEditableTextField extends StatelessWidget {
  final String ? text;

  const NonEditableTextField({super.key,this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).hintColor, width: 0.5)),
        ),
        child: Text(text!.tr,
          style: ubuntuMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.6),
            fontSize: Dimensions.fontSizeDefault),
        )
    );
  }
}