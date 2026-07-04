import 'package:purplestage_provider/utils/core_export.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ServiceOverview extends StatelessWidget {
  final ServiceDetailsController serviceDetailsController;
  const ServiceOverview({super.key,required this.serviceDetailsController});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child:  Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Center(
          child: HtmlWidget(
          serviceDetailsController.serviceDetailsModel!.content!.description!,
            textStyle: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}