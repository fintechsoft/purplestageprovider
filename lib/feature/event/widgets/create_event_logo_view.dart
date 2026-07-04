import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class CreateEventLogoView extends StatelessWidget {
  const CreateEventLogoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventController eventController = Get.find();
    return Stack(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(10),
          child: eventController.networkPosterImage == null && eventController.pickedPosterImage != null ?
          Image.file(File(eventController.pickedPosterImage!.path),
              fit: BoxFit.cover, height: 100, width: 100
          ): eventController.networkPosterImage != null && eventController.pickedPosterImage == null ?
          CustomImage(height: 100, width: 100, image: "${eventController.networkPosterImage}"): const SizedBox(),
        ),
        Positioned(top: -10, right: -10,
            child: IconButton(onPressed: ()=> eventController.pickPosterImage(true),
                icon: const Icon(Icons.highlight_remove_rounded,color: Colors.red,size: 25)
            )
        ),
      ],
    );
  }
}