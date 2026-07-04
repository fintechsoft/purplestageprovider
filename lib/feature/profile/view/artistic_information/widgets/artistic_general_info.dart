import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class ArtisticGeneralInfo extends StatefulWidget {
  const ArtisticGeneralInfo({super.key});
  @override
  State<ArtisticGeneralInfo> createState() => _GeneralInfoState();
}
class _GeneralInfoState extends State<ArtisticGeneralInfo> {

  final FocusNode _groupNameFocus= FocusNode();
  final FocusNode _contactPersonNameFocus= FocusNode();
  final FocusNode _PhoneFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _achievementsFocus = FocusNode();
  final FocusNode _categorynameFocus = FocusNode();
  final FocusNode _sociallink1Focus = FocusNode();
  final FocusNode _sociallink2Focus = FocusNode();
  final FocusNode _sociallink3Focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: GetBuilder<UserProfileController>(builder: (userProfileController) {
        return Form(key: userProfileController.artisticInformationFormKey,
          child: Container(color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        ),
                        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Artistic Information", style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge
                            )),
                            artisticImageSection(userProfileController),
                            companyOrIndividualInfoSection(userProfileController,context),
                            Text("Which all promotional services you can provide",style: ubuntuBold.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color!,)),
                            PromotionServicesWidget(userProfileController,context),
                            userProfileController.selectedServices.contains('Other')
                                ? TextField(
                              controller: userProfileController.serviceOtherController,
                              decoration: InputDecoration(labelText: 'Specify other service'),
                            )
                                : SizedBox.shrink(),
                            Text("Mention other deliverable which may be provided by you",style: ubuntuBold.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color!,)),
                            CustomTextField(
                              title: "other deliverable",
                              controller: userProfileController.otherdeliverableController,
                              hintText: "other deliverable which may be provided by you",
                              maxLines: 3,
                              inputAction: TextInputAction.next,
                              onValidate: (value){
                                return (value == null || value.isEmpty) ? "other deliverable" : null;
                              },
                            ),
                            const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                            Text("Cash honorarium",style: ubuntuBold.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color!,)),
                            CashHonorariumWidget(userProfileController,context),
                            userProfileController.selectedHonorarium=='Other'
                                ? TextField(
                              controller: userProfileController.cashOtherController,
                              decoration: InputDecoration(labelText: 'Specify other Cash Honororium'),
                            )
                                : SizedBox.shrink(),
                            Text("Benefits in kind ",style: ubuntuBold.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color!,)),
                            BenefitsInKindWidget(userProfileController,context),
                            userProfileController.selectedBenefits.contains('Other')
                                ? TextField(
                              controller: userProfileController.serviceOtherController,
                              decoration: InputDecoration(labelText: 'Specify other Banefits'),
                            )
                                : SizedBox.shrink(),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                          ],),
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                    ]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: CustomButton(
                    btnTxt: "save".tr,
                    isLoading: userProfileController.isLoading,
                    onPressed: ()=> _updateArtistic(context,userProfileController),
                  ),
                ),

                const SizedBox(height: 15,)
              ],
            ),
          ),
        );

      })
    );
  }

  Widget artisticImageSection(UserProfileController userProfileController) {
    return Container(
      height: 120,
      width: Get.width,
      margin:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Center(
        child: Stack(alignment: AlignmentDirectional.center,
          children: [
            userProfileController.artisticpickedFile == null ?
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CustomImage(
                height: 100, width: 100, image: userProfileController.artisticModel?.artisticinfo?.logoFullPath ?? "",
                placeholder: Images.userPlaceHolder,
              ),
            ) : CircleAvatar(radius: Dimensions.paddingSizeExtraLarge * 2, backgroundImage:FileImage(File(userProfileController.artisticpickedFile!.path))),

            IconButton( onPressed: ()=>userProfileController.pickArtistic(),
              icon: Icon(Icons.camera_enhance_rounded, color: light.cardColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget companyOrIndividualInfoSection(UserProfileController userProfileController,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeSmall,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            title: "Individual / Team Name",
            controller: userProfileController.cNameController,
            hintText: "Individual / Team Name",
            maxLines: 1,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _groupNameFocus,
            nextFocus: _contactPersonNameFocus,
            onValidate: (value){
              return (value == null || value.isEmpty) ? "Individual / Team Name" : null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            title: "Representative / Contact Person Name",
            controller: userProfileController.personNameController,
            hintText: "Representative / Contact Person Name",
            maxLines: 1,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _contactPersonNameFocus,
            nextFocus: _PhoneFocus,
            onValidate: (value){
              return (value == null || value.isEmpty) ? "Representative / Contact Person Name" : null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            onCountryChanged: (CountryCode countryCode){
              userProfileController.countryDialCode = countryCode.dialCode!;
            },
            countryDialCode:  userProfileController.countryDialCode,
            title: "phone_number".tr,
            hintText: 'Enter Contact No',
            controller: userProfileController.cPhoneController,
            inputType: TextInputType.phone,
            inputAction: TextInputAction.next,
            focusNode: _PhoneFocus,
            nextFocus: _categorynameFocus,
            onValidate: (value){
              if(value == null || value.isEmpty){
                return 'phone_number_hint'.tr;
              }else{
                return FormValidationHelper().isValidPhone(
                    userProfileController.countryDialCode+value
                );
              }
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          Container(width: Get.width, height: 40,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color:Theme.of(context).hintColor)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(padding: EdgeInsets.zero, dropdownColor: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
                elevation: 2,
                hint: Text(userProfileController.selectedCategory,
                  style: ubuntuRegular.copyWith(
                    color: userProfileController.selectedCategory==''?
                    Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):
                    Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                    fontSize: userProfileController.selectedCategory ==''? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: userProfileController.categorylist.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Row(children: [
                      Text(items,
                        style: ubuntuRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                        ),
                      ),
                    ]),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  userProfileController.setselectedCategory(newValue!);
                  setState(() {
                    userProfileController.categorynameController?.text=newValue;
                  });
                },
              ),
            ),
          ),
          userProfileController.selectedCategory=="Other"? SizedBox(height: Dimensions.paddingSizeExtraMoreLarge):SizedBox(),
          Visibility(
            visible: userProfileController.selectedCategory=="Other",
            child: CustomTextField(
              title: "Other Category Name",
              controller: userProfileController.categorynameController,
              hintText: "Other Category Name",
              maxLines: 1,
              capitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
              focusNode: _categorynameFocus,
              nextFocus: _sociallink1Focus,
              onValidate: (value){
                return (value == null || value.isEmpty) ? "Other Category Name" : null;
              },
              onChanged: (value){
                setState(() {
                  userProfileController.setselectedCategory(value);
                });
              },
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            title: "Social Link 1",
            controller: userProfileController.sociallink1Controller,
            hintText: "Social Link 1",
            maxLines: 1,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _sociallink1Focus,
            nextFocus: _sociallink2Focus,
            onValidate: (value){
              return (value == null || value.isEmpty) ? "Social Link 1" : null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            title: "Social Link 2",
            controller: userProfileController.sociallink2Controller,
            hintText: "Social Link 2",
            maxLines: 1,
            isRequired: false,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _groupNameFocus,
            nextFocus: _contactPersonNameFocus,
            onValidate: (value){
             // return (value == null || value.isEmpty) ? "Individual / Team Name" : null;
              return null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            title: "Social Link 3",
            controller: userProfileController.sociallink3Controller,
            hintText: "Social Link 3",
            maxLines: 1,
            isRequired: false,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _sociallink3Focus,
            nextFocus: _bioFocus,
            onValidate: (value){
             // return (value == null || value.isEmpty) ? "Individual / Team Name" : null;
              return null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            title: "Bio",
            controller: userProfileController.bioController,
            hintText: "Bio",
            maxLines: 3,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _bioFocus,
            nextFocus: _achievementsFocus,
            onValidate: (value){
              return (value == null || value.isEmpty) ? "Bio" : null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
          CustomTextField(
            title: "Achievements",
            controller: userProfileController.achievementsController,
            hintText: "",
            maxLines: 3,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _achievementsFocus,
            nextFocus: _sociallink1Focus,
            onValidate: (value){
              return (value == null || value.isEmpty) ? "Bio" : null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
        ],
      ),
    );
  }

  @override
  Widget PromotionServicesWidget (UserProfileController userProfileController,BuildContext context) {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: userProfileController.promotionOptions.map((option) {
  return CheckboxListTile(
  title: Text(option,style: ubuntuRegular.copyWith(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),)),
  value: userProfileController.selectedServices.contains(option),
  onChanged: (bool? value) {
  setState(() {
  if (value == true) {
    userProfileController.selectedServices.add(option);
  } else {
    userProfileController.selectedServices.remove(option);
  }
  });
  },
  );
  }).toList(),
  );
  }

  @override
  Widget CashHonorariumWidget (UserProfileController userProfileController,BuildContext context) {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: userProfileController.cashOptions.map((option) {
  return RadioListTile<String>(
  title: Text(option,style: ubuntuRegular.copyWith(
  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),)),
  value: option,
  groupValue: userProfileController.selectedHonorarium.trim(),
  onChanged: (String? value) {
  setState(() {
    userProfileController.selectedHonorarium = value;
  });
  },
  );
  }).toList()
  );
  }

  @override
  Widget BenefitsInKindWidget (UserProfileController userProfileController,BuildContext context){
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: userProfileController.benefitsOptions.map((option) {
  return CheckboxListTile(
  title: Text(option,style: ubuntuRegular.copyWith(
  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),),),
  value: userProfileController.selectedBenefits.contains(option),
  onChanged: (bool? value) {
  setState(() {
  if (value == true) {
    userProfileController.selectedBenefits.add(option);
  } else {
    userProfileController.selectedBenefits.remove(option);
  }
  });
  },
  );
  }).toList()
  );
  }


  _updateArtistic(BuildContext context, UserProfileController userProfileController) {
    if(userProfileController.artisticInformationFormKey.currentState!.validate() ){
      if (kDebugMode) {
        print("Everything is perfect");
      }
      userProfileController.updateArtistic().then((status){
        if(status.isSuccess!){
          showCustomSnackBar("Artistic Profile Updated Successfully".tr, type: ToasterMessageType.success);
        }
        else{showCustomSnackBar(status.message);}
      });
    }

  }
}
