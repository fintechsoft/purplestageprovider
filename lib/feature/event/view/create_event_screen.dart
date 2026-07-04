import 'package:purplestage_provider/feature/event/widgets/preview_provider_event_widget.dart';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';


class CreateEventScreen extends StatefulWidget {
  final bool isEditScreen;
  final bool fromDetailsScreen;
  final bool isForResubmit;
  final EventData? eventData;
  const CreateEventScreen({super.key, required this.isEditScreen, this.eventData, this.fromDetailsScreen = false, this.isForResubmit = false});
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}
class _CreateEventScreenState extends State<CreateEventScreen> with SingleTickerProviderStateMixin {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _validationFocus = FocusNode();
  final FocusNode _eventNameFocus = FocusNode();
  final FocusNode _institutionNameFocus = FocusNode();
  final FocusNode _contactNoFocus = FocusNode();
  final FocusNode _typeOfEventFocus = FocusNode();
  final FocusNode _eventTimeFocus = FocusNode();
  final FocusNode _venueFocus = FocusNode();
  final FocusNode _eventDescriptionFocus = FocusNode();
  final FocusNode _posterDescriptionFocus = FocusNode();


  TextEditingController eventNameController = TextEditingController();
  TextEditingController institutionNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController typeOfEventController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController posterDescriptionController = TextEditingController();
  String typeOfEvent = '';
  bool isPaid = false;
  bool isChecked = false;
  bool isVerified = false;


  @override
  void initState() {
    if(widget.isEditScreen){
      eventNameController.text = widget.eventData?.eventName ?? "";
      institutionNameController.text = widget.eventData?.institutionName ?? "";
      contactNoController.text = widget.eventData?.contactNo ?? "";
      venueController.text = widget.eventData?.venue ?? "";
      eventDescriptionController.text = widget.eventData?.eventDescription ?? "";
      typeOfEvent = widget.eventData?.typeOfEvent ?? '';
      isPaid = widget.eventData?.isPaid == 1;

      EventController eventController = Get.find();
      eventController.initializeEventValues(widget.eventData!);
    }
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controllers
    eventNameController.dispose();
    institutionNameController.dispose();
    contactNoController.dispose();
    venueController.dispose();
    eventDescriptionController.dispose();
    super.dispose();
  }

  Future<DateTime?> pickDateTime(BuildContext context) async {
    // Pick a date first
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) {
      // If the user canceled the date picker, return null
      return null;
    }

    // Pick a time after date selection
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) {
      // If the user canceled the time picker, return only the date
      return null;
    }

    // Combine date and time into a single DateTime object
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<EventController>( builder: (eventController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(title: widget.isEditScreen && !widget.isForResubmit? "Edit Event" : "Create New Event"),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              physics:  const BouncingScrollPhysics(),
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow, color: Theme.of(context).cardColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: 0),
                margin: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,Dimensions.paddingSizeSmall,Dimensions.paddingSizeSmall,3),
                child: Form(key: formKey, autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      if(!eventController.isDateRangeValid)
                        Padding(padding: const EdgeInsets.only(top : 5),
                          child: Text('fill_required_field'.tr,
                            style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeSmall),
                          ),
                        )
                    ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        color: Theme.of(context).primaryColor.withOpacity(0.04)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
                      child: Column(children: [
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        CustomTextFieldWidget(
                          titleText: "Event Name",
                          controller: eventNameController,
                          focusNode: _eventNameFocus,
                          nextFocus:  _institutionNameFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          labelText: 'Event Name',
                          required: true,
                          validator: (value) => (value == null || value.isEmpty) ? "enter Event Name" : null,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        CustomTextFieldWidget(
                          titleText: "Organiser /institution Name",
                          controller: institutionNameController,
                          focusNode: _institutionNameFocus,
                          nextFocus:  _contactNoFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          labelText: 'Organiser /institution Name ',
                          required: true,
                          validator: (value) => (value == null || value.isEmpty) ? "enter Organiser /institution Name " : null,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        CustomTextFieldWidget(
                          titleText: "Contact Number",
                          controller: contactNoController,
                          focusNode: _contactNoFocus,
                          nextFocus:  _typeOfEventFocus,
                          inputType: TextInputType.phone,
                          capitalization: TextCapitalization.words,
                          labelText: 'Contact Number',
                          required: true,
                          validator: (value) => (value == null || value.isEmpty) ? "enter Contact Number " : null,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        Container(width: Get.width, height: 40,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:Theme.of(context).hintColor)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(padding: EdgeInsets.zero, dropdownColor: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(5),
                              elevation: 2,
                              hint: Text(eventController.selectedEventType,
                                style: ubuntuRegular.copyWith(
                                  color: eventController.selectedEventType==''?
                                  Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):
                                  Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                                  fontSize: eventController.selectedEventType ==''? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
                                ),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: eventController.eventType.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Row(children: [
                                    Text(items.tr,
                                      style: ubuntuRegular.copyWith(
                                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                                      ),
                                    ),
                                  ]),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                              eventController.setEventType(type: newValue!);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        InkWell(
                          onTap:()async{
                            DateTime? eventdateTime = await pickDateTime(context);
                            if(eventdateTime != null){
                              eventController.eventdateTime = eventdateTime;
                              eventController.eventTimeController?.text =
                                  eventController.setEventDateTime();
                            }
                            setState(() {
                              formKey.currentState!.validate();
                            });
                          },
                          child: CustomTextField(
                            inputType: TextInputType.text,
                            controller: eventController.eventTimeController,
                            hintText: "Event Date & Time",
                            title: "Event Date & Time",
                            focusNode: _eventTimeFocus,
                            capitalization: TextCapitalization.sentences,
                            inputAction: TextInputAction.done,
                            isEnabled :  false,
                            suffixIcon: Images.customCalender,
                            onValidate: (value){
                              if(value == null || value.isEmpty){
                                return "Enter Event Date & Time";
                              }else if (value.isNotEmpty){
                                if(widget.isEditScreen){
                                  bool isNotValidEventDate = eventController.validateEventDateTime();
                                  if(isNotValidEventDate){
                                    return "Enter a valid date";
                                  }
                                }
                              }
                              return null;

                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        CustomTextFieldWidget(
                          titleText: "Venue Details",
                          controller: venueController,
                          focusNode: _venueFocus,
                          nextFocus:  _eventDescriptionFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          labelText: 'Venue Details',
                          required: true,
                          validator: (value) => (value == null || value.isEmpty) ? "enter Venue Details" : null,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        CustomTextFieldWidget(
                          titleText: "Event Description",
                          controller: eventDescriptionController,
                          focusNode: _eventDescriptionFocus,
                          nextFocus:  _posterDescriptionFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          labelText: 'Event Description',
                          required: true,
                          maxLines: 4,
                          validator: (value) => (value == null || value.isEmpty) ? "enter Event Description" : null,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        CustomTextFieldWidget(
                          titleText: "Poster Description",
                          controller: posterDescriptionController,
                          focusNode: _posterDescriptionFocus,
                          inputType: TextInputType.text,
                          capitalization: TextCapitalization.words,
                          labelText: 'Poster Description',
                          required: true,
                          maxLines: 4,
                          validator: (value) => (value == null || value.isEmpty) ? "enter Poster Description" : null,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                      ]),
                    ),
                      TextFieldTitle(title:"Upload Event Poster", subtitle : "(2:1)", requiredMark: true),
                      eventController.pickedPosterImage != null || eventController.networkPosterImage != null ? Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 20/9,
                            child: eventController.pickedPosterImage != null && eventController.networkPosterImage == null ? ClipRRect(borderRadius: BorderRadius.circular(10),
                              child: Image.file(File(eventController.pickedPosterImage!.path),
                                  fit: BoxFit.cover, height: 100, width: 100
                              ),
                            ): eventController.networkPosterImage != null && eventController.pickedPosterImage == null ?
                            AspectRatio(
                                aspectRatio : 20/9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomImage(
                                      image: "${eventController.networkPosterImage}"),
                                )
                            ): const SizedBox(),
                          ),
                          Positioned(top: -10, right: -10,
                              child: IconButton(onPressed: ()=> eventController.pickPosterImage(true),
                                  icon: const Icon(Icons.highlight_remove_rounded,color: Colors.red,size: 25)
                              )
                          ),
                        ],
                      )
                          :
                      AspectRatio(
                        aspectRatio: 20/9,
                        child: DottedVideoBorder(
                          showErrorBorder: !eventController.isPosterImageValid,
                          text: 'Upload Event Photo',
                          onTap: ()=> eventController.pickPosterImage(false),
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),

                    ]),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(btnTxt: "reset".tr,
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  textColor: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.8),
                  width: 100,height: 40,
                  onPressed: (){
                  if(widget.isEditScreen){
                    eventController.initializeEventValues(eventController.eventData!);
                  }else{
                    eventController.resetAllValues(shouldUpdate: true);
                  }

                  },
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                CustomButton(
                  btnTxt: widget.isEditScreen && !widget.isForResubmit? "re_submit".tr : "submit".tr, fontSize: Dimensions.fontSizeSmall, width: 100, height: 40,
                  isLoading : eventController.isLoading,
                  onPressed: (){
                    eventController.checkValidation();
                    if(widget.isEditScreen){
                        if(formKey.currentState!.validate() && eventController.isPosterImageValid){
                          if(widget.isForResubmit){
                            eventController.reSubmitEvent(
                                widget.eventData!,
                                eventNameController: eventNameController,
                                institutionNameController: institutionNameController,  // add this controller
                                contactNoController: contactNoController,           // add this controller
                                typeOfEventController: typeOfEventController,       // add this controller
                                eventDescriptionController: eventDescriptionController,
                                posterDescriptionController: posterDescriptionController, // add this controller
                                venueController: venueController,                 // add this controller
                                eventTime:eventController.eventdateTime!,                     // DateTime variable
                                isPaid: isPaid,                             // boolean variable
                                eventPoster: eventController.pickedPosterImage                          // optional XFile variable
                            );
                          }else{
                            eventController.editEvent(
                                widget.eventData!,
                                eventNameController: eventNameController,
                                institutionNameController: institutionNameController,  // add this controller
                                contactNoController: contactNoController,           // add this controller
                                typeOfEventController: typeOfEventController,       // add this controller
                                eventDescriptionController: eventDescriptionController,
                                posterDescriptionController: posterDescriptionController, // add this controller
                                venueController: venueController,                 // add this controller
                                eventTime:eventController.eventdateTime!,                     // DateTime variable
                                isPaid: isPaid,                             // boolean variable
                                eventPoster: eventController.pickedPosterImage,
                                isFromDetailsPage: false                          // optional XFile variable
                            );
                          }
                        }
                    }else{
                        if(formKey.currentState!.validate() && eventController.isPosterImageValid){
                          eventController.submitEvent(
                              eventNameController: eventNameController,
                              institutionNameController: institutionNameController,  // add this controller
                              contactNoController: contactNoController,           // add this controller
                              typeOfEventController: eventController.selectedEventType,       // add this controller
                              eventDescriptionController: eventDescriptionController,
                              posterDescriptionController: posterDescriptionController, // add this controller
                              venueController: venueController,                 // add this controller
                              eventTime:eventController.eventdateTime!,                     // DateTime variable
                              isPaid: isPaid,                             // boolean variable
                              eventPoster: eventController.pickedPosterImage);// optional XFile variable);
                        }
                    }
                   },
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

              ],
            ),
          ),
        ]),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            heroTag: 'create_screen',
            shape: const CircleBorder(),
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              showCustomDialog(child: PreviewProviderEventWidget(
                eventName: eventNameController.text,
                institutionName:institutionNameController.text,
                contactNo:contactNoController.text,
                typeOfEvent:eventController.selectedEventType,
                eventTime:eventTimeController.text,
                venue:venueController.text,
                eventDescription:eventDescriptionController.text,
                posterDescription:posterDescriptionController.text,
                networkPosterImage:eventController.networkPosterImage,
                pickedPosterImage:eventController.pickedPosterImage?.path,
              ), barrierDismissible: true);
            },
            child: Icon(Icons.remove_red_eye_sharp, color: light.cardColor),
          ),
        ),
      );
    });
  }
}






