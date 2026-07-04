import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class EventDetailsScreen extends StatefulWidget {
  final String? id;
  final String? fromNotification;
  final EventData eventDataDetails;

  const EventDetailsScreen({
    super.key,
    required this.id,
    this.fromNotification = "",
    required this.eventDataDetails,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  // EventData? eventdata;
  @override
  void initState() {
    Get.find<EventController>().setEventData(widget.eventDataDetails);
    // eventdata=widget.eventDataDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      builder: (eventController) {
        return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: "Event Details",
              onBackPressed: () {
                if (widget.fromNotification == "fromNotification") {
                  Get.offAllNamed(RouteHelper.getInitialRoute());
                } else if (Navigator.canPop(context)) {
                  Get.back();
                }
              },
            ),
            // body: eventController.eventData == null
              body: eventController.eventData == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: cardShadow,
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEventHeader(eventController),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Divider(
                          height: 0.5,
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        _buildBookingItems(eventController),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  _buildServiceInfo(eventController),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  _buildPosterInfo(eventController),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  _buildPosterImage(eventController),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            bottomSheet: _buildBottomSheet(eventController),
          ),
        );
      },
    );
  }

  Widget _buildEventHeader(EventController eventController) {
    bool isExpired = eventController.isEventExpired(eventController.eventData!.eventTime!);
    String? status = eventController.eventData?.bookingStatus;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Event Id :' + " #${eventController.eventData?.readableId}",
                overflow: TextOverflow.ellipsis,
                style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.9),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Get.isDarkMode
                        ? Colors.grey.withOpacity(0.2)
                        : ColorResources.buttonBackgroundColorMap[eventController.eventData?.bookingStatus],
                  ),
                  child: Center(
                    child: Text(
                      "${eventController.eventData?.bookingStatus}".tr,
                      style: ubuntuMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Get.isDarkMode
                            ? Theme.of(context).primaryColorLight
                            : ColorResources.buttonTextColorMap[eventController.eventData?.bookingStatus],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                if (isExpired || (!isExpired && status == "approved"))
                  Text(
                    '(${(!isExpired && status == "approved") ? 'running'.tr : 'expired'.tr})',
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Divider(
          height: 0.5,
          color: Theme.of(context).hintColor.withOpacity(0.5),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text("${eventController.eventData?.eventName}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 5,
                style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.9),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingItems(EventController eventController) {
    return Column(
      children: [
        BookingItem(
          img: Images.iconCalendar,
          title: 'Event Created',
          subTitle: DateConverter.dateMonthYearTime(
              DateConverter.isoUtcStringToLocalDate(eventController.eventData?.createdAt ?? "")),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall + 2),
        BookingItem(
          img: Images.iconCalendar,
          title: 'Event Date',
          subTitle: DateConverter.dateMonthYearTime(
              DateConverter.isoUtcStringToLocalDatee(eventController.eventData?.eventTime ?? "")),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall + 2),
        BookingItem(
          img: Images.paymentStatus,
          title: 'Event Fees',
          subTitle: eventController.eventData?.isPaid == 1 ? "Paid" : "Free",
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          subtitleTextStyle: ubuntuMedium.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceInfo(EventController eventController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: cardShadow,
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("description".tr.replaceAll(":", ""), style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            "${eventController.eventData?.eventDescription}",
            style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor),
            textAlign: TextAlign.justify,
            maxLines: 100,
          ),
        ],
      ),
    );
  }
  Widget _buildPosterImage(EventController eventController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: cardShadow,
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              color: Theme.of(context).hintColor.withOpacity(0.1),
              border: Border.all(
                color: Theme.of(context).hintColor.withOpacity(0.2),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 25),
            child: CustomImage(
              image: eventController.eventData!.eventPosterFullPath,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPosterInfo(EventController eventController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: cardShadow,
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Poster Description", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            "${eventController.eventData?.posterDescription}",
            style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor),
            textAlign: TextAlign.justify,
            maxLines: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(EventController eventController) {
    return eventController.eventData != null && eventController.eventData != null
        ? Container(
      height: 60,
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: shadow),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              btnTxt: "Edit Event",
              fontSize: Dimensions.fontSizeDefault,
              icon: Icons.edit,
              onPressed: () {
                Get.to(() => CreateEventScreen(
                  isEditScreen: true,
                  eventData: eventController.eventData,
                  fromDetailsScreen: true,
                ));
              },
            ),
          ),
          if (eventController.eventData?.bookingStatus == 'pending') const SizedBox(width: Dimensions.paddingSizeDefault),
        ],
      ),
    )
        : const SizedBox();
  }
}


class EventDetailsEmptyScreen extends StatelessWidget {
  final String eventId;
  const EventDetailsEmptyScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Image.asset(Images.noResults, height: Get.height * 0.1, color: Theme.of(context).primaryColor,),
      const SizedBox(height: Dimensions.paddingSizeLarge,),
      Text("information_not_found".tr, style: ubuntuRegular,),
      const SizedBox(height: Dimensions.paddingSizeLarge,),

      CustomButton(
        height: 35, width: 120, radius: Dimensions.radiusExtraLarge,
        btnTxt: "go_back".tr, onPressed: () async {
        await Get.find<EventController>().removeEventItemFromList(eventId, shouldUpdate: true);
        Get.back();
      },)

    ],),);
  }
}
