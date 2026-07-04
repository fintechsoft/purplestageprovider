import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class EventMenuItem extends GetView<EventController> {
  const EventMenuItem({super.key, required this.title,this.index, required this.image});
  final String title;
  final String image;
  final int? index;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      padding: const EdgeInsets.fromLTRB(15,0,10,0
          //vertical: 5
      ),
      decoration: BoxDecoration(
          color: controller.currentIndex !=index && Get.isDarkMode? Colors.grey.withOpacity(0.2):controller.currentIndex ==index?
          Theme.of(context).primaryColor: Theme.of(context).primaryColor.withOpacity(0.08),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Image.asset(image, height: 18, width: 18),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Text(title.tr,textAlign: TextAlign.center,
            style:ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: controller.currentIndex == index? Colors.white : Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7)
            ),
          ),

        ],
      ),
    );
  }
}