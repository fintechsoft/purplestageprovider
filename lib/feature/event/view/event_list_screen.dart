import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen>{

  bool? isDataAvailable;

  @override
  void initState() {
    super.initState();
    Get.find<EventController>().updateEventTabIndex(0, shouldUpdate: false);
    // if(!widget.isDataAvailable){
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     showCustomDialog(child: const AddEventDialog(),);
    //   });
    // }else{
      Get.find<EventController>().getEventList('all',1,reload: true, isFirst: true);
    // }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Event List'),
      body: GetBuilder<EventController>(
        builder:(eventController){
          // if(!widget.isDataAvailable){
            isDataAvailable = Get.find<EventController>().eventDataList != null &&  Get.find<EventController>().eventDataList!.isNotEmpty;
          print("details : $isDataAvailable");
            // }else{
          //   isDataAvailable = widget.isDataAvailable;
          // }
          return isDataAvailable != null && !isDataAvailable! ? Center(
            child: SizedBox(height: Get.height * 0.7,
              child: NoDataScreen(
                text: "No Event Created Yet",
                type: NoDataType.event,
              ),
            ),
          ) : Column(children: [
            const EventMenuBar(),
            Expanded(
              child: TabBarView(
                controller: eventController.listTabController,
                dragStartBehavior: DragStartBehavior.down,
                children: const [
                  EventList(),
                  EventList(),
                  EventList(),
                  EventList(),
                  EventList(),
                  EventList(),
                  EventList(),
                ],
              ),
            ),
          ],);
        },
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.find<EventController>().resetAllValues();
          Get.to(()=>const CreateEventScreen(isEditScreen: false));
        },
        child: Icon(Icons.add, color: light.cardColor),
      ),

    );
  }
}



class TurnOnServiceAvailability extends StatelessWidget {
  const TurnOnServiceAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

          Text("service_availability_option_has_turned_off".tr, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
            textAlign: TextAlign.center,),

          const SizedBox(height: Dimensions.paddingSizeDefault,),

          InkWell(
            onTap: () => Get.to(const BusinessSettingScreen()),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                border: Border.all(color: Theme.of(context).primaryColor),
              ), padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall-3),
                child: Text("go_to_business_settings".tr, style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor),)),
          )

        ],),
      ),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  int value = 1;

  @override
  void initState() {
    super.initState();

    Get.find<EventController>().listTabController?.addListener(() {

      if(value==1){
        Future.delayed(const Duration(milliseconds: 100), (){

          Get.find<EventController>().menuScrollController?.scrollToIndex(
            Get.find<EventController>().listTabController!.index, preferPosition: AutoScrollPosition.middle,
            duration: const Duration(milliseconds: 500),
          );
          Get.find<EventController>().menuScrollController?.highlight( Get.find<EventController>().listTabController!.index);
          Get.find<EventController>().updateEventTabIndex( Get.find<EventController>().listTabController!.index);

          Get.find<EventController>().getEventList(Get.find<EventController>().eventStatusList[Get.find<EventController>().listTabController!.index], 1, reload: true);

        });
        value--;
      }
    });

    }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<EventController>(builder: (eventController){
      return eventController.eventDataList == null ?
      const BookingRequestItemShimmer(): eventController.eventDataList!.isEmpty ?
      Center(
        child: SizedBox(height: Get.height * 0.7,
          child: NoDataScreen(
            text: '${'you_have_not'.tr} ${eventController.eventStatus.tr.toLowerCase()} ${"request_yet".tr}',
            type: NoDataType.request,
          ),
        ),
      ) : const EventListview();
    });
  }
}
