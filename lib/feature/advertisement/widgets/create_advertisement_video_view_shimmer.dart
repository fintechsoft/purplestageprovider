import 'package:purplestage_provider/utils/core_export.dart';

class CreateAdvertisementVideoViewShimmer extends StatelessWidget {
  const CreateAdvertisementVideoViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: Theme.of(context).hintColor.withOpacity(0.2),
        ),
      ),
    );
  }
}
