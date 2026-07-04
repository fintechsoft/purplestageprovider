import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class EventListview extends StatelessWidget {
  const EventListview({super.key,});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      builder: (eventController) {
        return Column(
          children:[
            eventController.eventDataList!.isNotEmpty ?
            Expanded(
              child: RefreshIndicator(

                color: Theme.of(context).primaryColorLight,
                backgroundColor: Theme.of(context).cardColor,
                onRefresh: () async {
                  Get.find<EventController>().getEventList(Get.find<EventController>()
                      .eventStatusList[Get.find<EventController>().currentIndex],1,
                  );
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics()
                  ),
                  controller: eventController.scrollController,
                  itemCount: eventController.eventDataList?.length,
                  padding: EdgeInsets.only(bottom: eventController.isLoading ? 0 :  Dimensions.paddingSizeLarge * 3),
                  itemBuilder: (ctx,index)=> EventItem(
                      eventData : eventController.eventDataList![index]
                  ),
                ),
              ),
            ): const SizedBox.shrink(),

            eventController.isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
