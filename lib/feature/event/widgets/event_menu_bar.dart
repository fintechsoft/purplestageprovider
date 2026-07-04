import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class EventMenuBar extends StatefulWidget{
  const EventMenuBar({super.key});

  @override
  State<EventMenuBar> createState() => _EventMenuBarState();
}

class _EventMenuBarState extends State<EventMenuBar> {
  EventController controller   = Get.find();

  @override
  void initState() {
    super.initState();
    controller.menuScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.horizontal,
    );
    controller.menuScrollController!.scrollToIndex(controller.currentIndex, preferPosition: AutoScrollPosition.middle);
    controller.menuScrollController!.highlight(controller.currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Theme.of(context).colorScheme.surface,
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeSmall),
      child: ListView.builder(
        controller: controller.menuScrollController,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return GetBuilder<EventController>(builder: (controller){
            return InkWell(
              child: AutoScrollTag(
                controller: controller.menuScrollController!,
                key: ValueKey(index),
                index: index,
                child: EventMenuItem(
                  image: controller.eventStatusImageList[index],
                  title: controller.eventStatusList[index].toLowerCase(),
                  index: index,
                ),
              ),
              onTap: () async {
                controller.updateEventTabIndex(index);
                await controller.menuScrollController!.scrollToIndex(
                    index, preferPosition: AutoScrollPosition.middle,
                  duration: const Duration(milliseconds: 700)
                );
                await controller.menuScrollController!.highlight(index);
              },
            );
          });
        }
      ),
    );
  }
}