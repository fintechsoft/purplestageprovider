import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class EventItem extends StatelessWidget {
  final EventData eventData;
  const EventItem({
    super.key, required this.eventData,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(builder: (eventController){

      String adsStatus = eventController.getEventStatus(eventData.bookingStatus!,eventData.eventTime!);
      bool isExpired = eventController.isEventExpired(eventData.eventTime!);

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow,
        ),
        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start , children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
              Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraSmall+3,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween , crossAxisAlignment: CrossAxisAlignment.start, children: [ Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Event",
                        style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                        ),
                      ),
                      Text(" # ${eventData.readableId}",
                        style: ubuntuBold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault,),
                      if(eventController.currentIndex==0) Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraSmall -1,
                                horizontal: Dimensions.paddingSizeSmall,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Get.isDarkMode?Colors.grey.withOpacity(0.2):
                                ColorResources.buttonBackgroundColorMap[adsStatus],
                              ),
                              child: Center(
                                child: Text(adsStatus.tr,
                                  style:ubuntuMedium.copyWith( fontSize: 12,
                                    color:ColorResources.buttonTextColorMap[adsStatus],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: Dimensions.paddingSizeSmall,),

                            isExpired ? Expanded(
                              child: Text('(${'expired'.tr})', maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                              ),
                            ): const SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                ],
              ),),

              PopupMenuButton<PopupMenuModel>(
                shape:  RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault,)),
                  side: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.1))
                ),
                surfaceTintColor: Theme.of(context).cardColor,
                position: PopupMenuPosition.under, elevation: 8,
                shadowColor: Theme.of(context).hintColor.withOpacity(0.3),
                itemBuilder: (BuildContext context) {
                  return eventController.getPopupMenuList(eventData.bookingStatus!).map((PopupMenuModel option) {
                    return PopupMenuItem<PopupMenuModel>(
                      onTap: ()async{
                        if(option.title == "Edit Event"){
                          Get.to(()=>CreateEventScreen(isEditScreen: true, eventData: eventData));
                        }
                        else if (option.title == 'View Event'){
                          Get.to(()=> EventDetailsScreen(id: eventData.id ?? "",eventDataDetails: eventData,));
                        }
                        else if(option.title == "Delete Event"){
                          showCustomBottomSheet(child: ConfirmationBottomSheet(
                            image: Images.deleteDialogIcon, title: "Confirm Event Deletion",
                            description: "Deleting this event will remove it permanently. Are you sure you want to proceed?", status: option.title,
                            yesButtonPressed: () async{
                              await Get.find<EventController>().deleteEvent(id: eventData.id ?? "");
                            },
                          ));
                        } else if(option.title == "Cancel Event"){
                          showCustomBottomSheet(child: ConfirmationBottomSheet(
                            image: Images.deleteDialogIcon, title: "Confirm Event Cancellation",
                            description: "Cancelling this event will remove it front User List. Are you sure you want to proceed?", status: option.title,
                            yesButtonPressed: () async{
                              await Get.find<EventController>().deleteEvent(id: eventData.id ?? "");
                            },
                          ));
                        }
                      },
                      value: option,
                      height: 40,
                      child: Row(
                        children: [
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                          Icon(option.icon, size: Dimensions.fontSizeLarge,),
                          const SizedBox(width: Dimensions.paddingSizeSmall,),
                          Text(option.title.tr, style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall
                          ),),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: Icon(Icons.more_vert, color: Theme.of(context).hintColor.withOpacity(0.7),),
              )

            ],
            ),
          ),

          Container(height: 2,width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
              Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(children: [
                    Row(
                      children: [
                        Text("${'Event Created'}: ",
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,   color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6))
                        ),
                        Text(" ${DateConverter.isoStringToLocalDateOnly(eventData.createdAt!)}",
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,   color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)),
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),

                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                    Row(
                      children: [
                        Text("Event Date: ",
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall ,  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)),
                        ),
                        Text("${DateConverter.stringToLocalDateOnly(eventData.eventTime??"")}",
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall ,  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)),
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],),
                ),
                InkWell(
                  onTap: () => Get.to(()=>EventDetailsScreen(id: eventData.id ?? "",eventDataDetails: eventData,)),
                  child: Container(
                    margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    child: Icon(Icons.arrow_forward_rounded, color: Theme.of(context).primaryColor.withOpacity(0.6),),
                  ),
                )
              ],
            ),
          )
        ],),
      );
    });
  }
}
