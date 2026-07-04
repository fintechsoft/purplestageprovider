import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class GeneralInfo extends StatefulWidget {
  const GeneralInfo({super.key});
  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}
class _GeneralInfoState extends State<GeneralInfo> {

  final FocusNode _companyNameFocus= FocusNode();
  final FocusNode _companyPhoneFocus = FocusNode();
  final FocusNode _companyAddressFocus = FocusNode();
  final FocusNode _companyEmailFocus = FocusNode();

  final FocusNode _contactPersonNameFocus= FocusNode();
  final FocusNode _contactPersonPhoneFocus = FocusNode();
  final FocusNode _contactPersonEmailFocus = FocusNode();
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: GetBuilder<UserProfileController>(builder: (userProfileController) {
        return Form(key: userProfileController.profileInformationFormKey,
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


                            Text("basic_information".tr, style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge
                            )),


                            profileImageSection(userProfileController),


                            companyOrIndividualInfoSection(userProfileController,context),
                            const SizedBox(height: Dimensions.paddingSizeDefault),


                          ],),
                        ),
                      ),


                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [


                        Text("same_as_general_info".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                        const SizedBox(width: Dimensions.paddingSizeSmall),


                        SizedBox(width: Dimensions.paddingSizeLarge,
                          child: Checkbox(
                            checkColor: Theme.of(context).cardColor,
                            activeColor: Theme.of(context).primaryColor,
                            value: userProfileController.keepPersonalInfoAsCompanyInfo,
                            onChanged: (bool? isChecked) => userProfileController.togglePersonalInfoAsCompanyInfo(),
                          ),
                        ),


                      ]),


                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        ),
                        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


                            Text("contact_person_info_title".tr, style: ubuntuBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge
                            )),
                            const SizedBox(height: Dimensions.paddingSizeSmall),


                            personalInfoSection(userProfileController,context),
                            const SizedBox(height: Dimensions.paddingSizeSmall),


                          ]),
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge,),

                      const SizedBox(height: Dimensions.paddingSizeLarge),


                    ]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: CustomButton(
                    btnTxt: "save".tr,
                    isLoading: userProfileController.isLoading,
                    onPressed: ()=> _updateProfile(context,userProfileController),
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

  Widget profileImageSection(UserProfileController userProfileController) {
    return Container(
      height: 120,
      width: Get.width,
      margin:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Center(
        child: Stack(alignment: AlignmentDirectional.center,
          children: [
            userProfileController.pickedFile == null ?
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CustomImage(
                height: 100, width: 100, image: userProfileController.providerModel?.content?.providerInfo?.logoFullPath ?? "",
                placeholder: Images.userPlaceHolder,
              ),
            ) : CircleAvatar(radius: Dimensions.paddingSizeExtraLarge * 2, backgroundImage:FileImage(File(userProfileController.pickedFile!.path))),

            IconButton( onPressed: ()=>userProfileController.pickImage(),
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
            title: "company/individual_name".tr,
            controller: userProfileController.companyNameController,
            hintText: "company_name_hint".tr,
            maxLines: 1,
            capitalization: TextCapitalization.words,
            inputAction: TextInputAction.next,
            focusNode: _companyNameFocus,
            nextFocus: _companyPhoneFocus,
            onValidate: (value){
              return (value == null || value.isEmpty) ? "enter_contact_person_name".tr : null;
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),

          CustomTextField(
            onCountryChanged: (CountryCode countryCode){
              userProfileController.countryDialCode = countryCode.dialCode!;
            },
            countryDialCode:  userProfileController.countryDialCode,
            title: "phone_number".tr,
            hintText: 'enter_company_phone_number'.tr,
            controller: userProfileController.companyPhoneController,
            inputType: TextInputType.phone,
            inputAction: TextInputAction.next,
            focusNode: _companyPhoneFocus,
            nextFocus: _companyEmailFocus,
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

          CustomTextField(
            title: "email".tr,
            inputType: TextInputType.emailAddress,
            controller: userProfileController.companyEmailController,
            hintText:'enter_company_email_address'.tr,
            focusNode: _companyEmailFocus,
            nextFocus: _companyAddressFocus,
            onValidate: (value){
              if(value == null || value.isEmpty){
                return 'empty_email_hint'.tr;
              }else{
                return FormValidationHelper().isValidEmail(value);
              }
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),



          GetBuilder<LocationController>(builder: (locationController){

            String address = locationController.pickAddress!="" ? locationController.pickAddress
                : userProfileController.providerModel?.content?.providerInfo?.companyAddress??"";

            return  GestureDetector(
              onTap: (){
                Get.to(()=>const PickMapScreen());
              },
              child: CustomTextField(
                title: "address".tr,
                controller: userProfileController.companyAddressController!..text= address,
                hintText: "address_hint".tr,
                maxLines: 1,
                capitalization: TextCapitalization.sentences,
                inputAction: TextInputAction.next,
                focusNode: _companyAddressFocus,
                isEnabled: Get.find<LocationController>().pickAddress!=""? true : false,
                suffixIcon: Images.pickPointLocation,
                onPressedSuffix: (){
                  Get.to(()=>const PickMapScreen());
                },
                onValidate: (value){
                  return (value ==null || value.isEmpty) ? "enter_address".tr  : null;
                },
              ),
            );
          }),
          const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),


          TextFieldTitle(title:"select_zone".tr,requiredMark: true),
          Container(width: Get.width, height: 30,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color:Theme.of(context).disabledColor,width: 1
                )),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  menuMaxHeight: Get.height*.40,
                  dropdownColor: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  elevation: 8,
                  hint: Text(
                    userProfileController.selectedZoneName==""? userProfileController.myZone:userProfileController.selectedZoneName,
                    style: ubuntuRegular.copyWith(
                      color: userProfileController.selectedZoneName==''?
                      Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):
                      Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: userProfileController.zoneList.map((ZoneData zoneData) {
                    return DropdownMenuItem(
                      value: zoneData,
                      child: Text(zoneData.name!,
                        style: ubuntuRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (ZoneData? zoneData) {
                    userProfileController.setNewZoneValue(zoneData!.name!,zoneData.id!);
                    userProfileController.onProfileChangeValidationCheck();
                  },
                ),
              ),
            ),
          if(!userProfileController.isZoneValid)
            Padding(padding: const EdgeInsets.only(top : 5),
              child: Text("fill_required_field".tr,
                style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeSmall),
              ),
            ),
        ],
      ),
    );
  }

  Widget personalInfoSection(UserProfileController userProfileController,BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: Dimensions.paddingSizeDefault),
        CustomTextField(
          title: "contact_person_name".tr,
          controller: userProfileController.personalNameController,
          hintText: "enter_contact_person_name".tr,
          maxLines: 1,
          capitalization: TextCapitalization.words,
          inputAction: TextInputAction.next,
          focusNode: _contactPersonNameFocus,
          nextFocus: _contactPersonPhoneFocus,
          onValidate: (value){
            return (value ==null || value.isEmpty) ? "enter_contact_person_name".tr : null;
          },
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),

        CustomTextField(
          onCountryChanged: (CountryCode countryCode){
            userProfileController.countryDialCode = countryCode.dialCode!;
          },
          countryDialCode:  userProfileController.countryDialCode,
          title: "contact_person_phone".tr,
          hintText: 'enter_contact_person_phone_number'.tr,
          controller: userProfileController.personalPhoneController,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
          focusNode: _contactPersonPhoneFocus,
          nextFocus: _contactPersonEmailFocus,
          onValidate: (value){
            if(value == null || value.isEmpty){
              return 'phone_number_hint'.tr;
            }else{
              return FormValidationHelper().isValidPhone(userProfileController.countryDialCode+value);
            }
          },
        ),

        const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),


        CustomTextField(
          title: "contact_person_email".tr,
          controller: userProfileController.personalEmailController,
          hintText: "enter_contact_person_email_address".tr,
          maxLines: 1,
          focusNode: _contactPersonEmailFocus,
          inputAction: TextInputAction.done,
          onValidate: (value){
            if(value == null || value.isEmpty){
              return 'empty_email_hint'.tr;
            }else{
              return FormValidationHelper().isValidEmail(value);
            }
          },
        ),
    ]);
  }

  Widget sameAsGeneralInfoSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeExtraSmall),
      child: GetBuilder<UserProfileController>(builder: (userProfileController){
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("contact_personal_information".tr,
                  style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: ()=> userProfileController.togglePersonalInfoAsCompanyInfo(),
                  child: Container(height: 20, width: 20,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 1.2),
                    ),
                    child:  Center(
                      child: userProfileController.keepPersonalInfoAsCompanyInfo ?
                      Icon(Icons.check, color: Theme.of(context).primaryColor,size: Dimensions.fontSizeLarge,) :
                      const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault,),
                Text("same_as_general_info".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor),),
              ],
            ),
          ],
        );
      }),
    );
  }

  _updateProfile(BuildContext context, UserProfileController userProfileController) {
    if(userProfileController.profileInformationFormKey.currentState!.validate() &&
        userProfileController.isZoneValid){
      if (kDebugMode) {
        print("Everything is perfect");
      }
      userProfileController.updateProfile().then((status){

        if(status.isSuccess!){
          Get.find<AuthController>().updateToken();
          Get.find<SubcategorySubscriptionController>().getMySubscriptionData(1,false);
          showCustomSnackBar("profile_updated_successfully".tr, type: ToasterMessageType.success);
        }
        else{showCustomSnackBar(status.message);}
      });
    }

  }
}
