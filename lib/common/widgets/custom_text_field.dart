import 'package:purplestage_provider/common/widgets/code_picker_widget.dart';
import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';


class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool isPassword;
  final bool isShowBorder;
  final bool? isAutoFocus;
  final Function(String)? onSubmit;
  final bool isEnabled;
  final int? maxLines;
  final bool? isShowSuffixIcon;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final Function(CountryCode countryCode)? onCountryChanged;
  final String? Function(String? )? onValidate;
  final bool contentPadding;
  final double borderRadius;
  final bool isRequired;
  final String? prefixIcon;
  final Widget? errorWidget;
  final Function()? onPressedSuffix;
  final Color? fillColor;
  final String? suffixIcon;

  const CustomTextField(
      {super.key, this.hintText = '',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.isShowSuffixIcon = false,
        this.onSubmit,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.isShowBorder = false,
        this.isAutoFocus = false,
        this.countryDialCode,
        this.onCountryChanged,
        this.onChanged,
        this.onValidate,
        this.title,
        this.contentPadding= true,
        this.borderRadius = 10,
        this.isRequired = true,
        this.prefixIcon,
        this.errorWidget, this.onPressedSuffix, this.fillColor, this.suffixIcon,
      });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}


class CustomTextFieldState extends State<CustomTextField> {

  void onFocusChanged(){
    FocusScope.of(context).unfocus();
    FocusScope.of(Get.context!).requestFocus(widget.focusNode);
    widget.focusNode?.addListener(() {
      setState(() {
      });
    });
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange:  (v){},
      child: TextFormField(

        onTap: onFocusChanged,
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: ubuntuRegular.copyWith(fontSize:Dimensions.fontSizeDefault,color: widget.isEnabled==false?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):Theme.of(context).textTheme.bodyLarge!.color),
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).hintColor,
        textCapitalization: widget.capitalization!,
        enabled: widget.isEnabled,
        autofocus: widget.isAutoFocus!,

        autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
            : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
            : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
            : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
            : widget.inputType == TextInputType.url ? [AutofillHints.url]
            : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
        obscureText: widget.isPassword ? _obscureText : false,
        inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,

        decoration: InputDecoration(
          isCollapsed: widget.focusNode?.hasFocus == true || widget.isEnabled == true || widget.controller!.text.isNotEmpty ? false: true,
          isDense: widget.focusNode?.hasFocus == true || (widget.nextFocus != null && widget.nextFocus?.hasFocus == true) || widget.controller!.text.isNotEmpty ? false : true,
          label: widget.countryDialCode == null  ? Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text(widget.title ?? "",
              style: ubuntuMedium.copyWith(
                fontSize:  Dimensions.fontSizeDefault,
                  color: widget.errorWidget!=null ? Theme.of(context).colorScheme.error : ((widget.focusNode?.hasFocus == true || widget.controller!.text.isNotEmpty ) &&  widget.isEnabled) ? Theme.of(context).textTheme.bodyLarge?.color :  Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5) ,
              ),
            ),

            if(widget.isRequired)
              Padding(padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text("*", style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error),),
              )
          ],) : null,

          labelStyle: widget.countryDialCode == null ? ubuntuMedium.copyWith(fontSize: 20) : null,

          prefixIcon: widget.prefixIcon != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 5),
            child: Image.asset(widget.prefixIcon!, width: 20,height: 20, color: Theme.of(context).colorScheme.primary.withOpacity(0.4),),
          ) : widget.countryDialCode != null ? Padding( padding:  EdgeInsets.only(left: widget.isShowBorder == true ?  10: 0, top: 5),
            child: CodePickerWidget(
              onChanged: widget.onCountryChanged,
              initialSelection: widget.countryDialCode,
              favorite: [widget.countryDialCode ?? ""],
              showDropDownButton: true,
              padding: EdgeInsets.zero,
              showFlagMain: true,
              flagWidth: 27,
              enabled: widget.isEnabled,
              dialogSize: Size(Dimensions.webMaxWidth/2, Get.height*0.6),
              dialogBackgroundColor: Theme.of(context).cardColor,
              barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
              textStyle: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge, color: widget.isEnabled == false ?Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.6) :Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ): null,
          contentPadding:  EdgeInsets.only(
            top: widget.countryDialCode != null ? Dimensions.paddingSizeDefault : 0.0,
            bottom: Dimensions.paddingSizeExtraSmall,
            left:   0,
            right:  0,
          ),
          
          focusedBorder : widget.isShowBorder ? OutlineInputBorder(
            borderSide: BorderSide(color:  Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ) : UnderlineInputBorder(borderSide: BorderSide(color:  Theme.of(context).primaryColor)),

          enabledBorder :  UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
          errorBorder :  UnderlineInputBorder(borderSide: BorderSide(color:  Theme.of(context).colorScheme.error)),
          focusedErrorBorder :  UnderlineInputBorder(borderSide: BorderSide(color:  Theme.of(context).colorScheme.error)),
          border :  UnderlineInputBorder(borderSide: BorderSide(color:  Theme.of(context).colorScheme.error)),
          disabledBorder :  UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),



          hintText: widget.hintText,
          hintStyle: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).hintColor.withOpacity(Get.isDarkMode ? .5:1)),

          suffixIconConstraints: widget.isPassword ? BoxConstraints(
            minHeight: widget.focusNode?.hasFocus == true || widget.controller!.text.isNotEmpty ? 40 : 20,
          ): null,

          suffixIcon: widget.suffixIcon!=null?
          GestureDetector(
            onTap: widget.onPressedSuffix,
            child: Stack(
              alignment: widget.focusNode?.hasFocus == true || widget.controller!.text.isNotEmpty ? Alignment.bottomRight : Alignment.centerRight,
              children: [
                Image.asset(widget.suffixIcon!, height: 22, width: 22,color: Theme.of(context).primaryColor,),
              ],
            ),
          ) :
          widget.isPassword ?
          InkWell(
            onTap: _toggle,
            child: Stack(
              alignment: widget.focusNode?.hasFocus == true  || widget.controller!.text.isNotEmpty? Alignment.bottomCenter : Alignment.bottomRight,
              children: [
                Icon(_obscureText ? Icons.visibility_off : Icons.visibility,size: 20, color: Theme.of(context).hintColor.withOpacity(0.3)),
              ],
            ),
          ) : null,
        ),
        onFieldSubmitted: (text) => widget.nextFocus != null ?
        FocusScope.of(context).requestFocus(widget.nextFocus) :
        widget.onSubmit != null ? widget.onSubmit!(text) : null,
        onChanged: widget.onChanged,
        validator: widget.onValidate,

      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}