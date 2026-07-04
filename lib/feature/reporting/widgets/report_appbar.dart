import 'package:purplestage_provider/feature/reporting/view/report_search_filter.dart';
import 'package:get/get.dart';
import 'package:purplestage_provider/utils/core_export.dart';

class ReportAppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final Function()? onPressed;
  final String fromPage;
  final bool isFiltered;
  const ReportAppBarView({
    super.key,
    this.title,this.centerTitle=false, this.onPressed, required this.fromPage, this.isFiltered = false
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 5,
      titleSpacing: 0,
      surfaceTintColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).cardColor,
      shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
      centerTitle: centerTitle,
      title: Text(title!,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),),
      leading: IconButton(
        onPressed: onPressed ?? (){
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
      ),
      actions: [
        InkWell(
          onTap: (){

            Get.to(()=>ReportSearchFilter(fromPage: fromPage,));
          },
          child: Stack (
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  border:   isFiltered ? Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ) : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(3),
                child: Icon(
                  Icons.filter_list,
                  size: 30,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),

              isFiltered ? Positioned(
                top: -3, right: -3,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(2,0,2,0),
                  color: Theme.of(context).cardColor,
                  child: const Icon(Icons.circle, size: 10, color: Colors.red,),
                ),
              ) : const SizedBox()
            ],
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeDefault,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}
