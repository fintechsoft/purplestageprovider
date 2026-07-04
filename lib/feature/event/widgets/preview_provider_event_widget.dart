import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';
//
// class PreviewProviderEventWidget extends StatelessWidget {
//
//   final String? eventName;
//   final String? institutionName;
//   final String? contactNo;
//   final String? typeOfEvent;
//   final String? eventTime;
//   final String? venue;
//   final String? eventDescription;
//   final String? posterDescription;
//   final String? networkPosterImage;
//   final String? pickedPosterImage;
//
//   const PreviewProviderEventWidget({
//   super.key,
//   this.eventName,
//   this.institutionName,
//   this.contactNo,
//   this.typeOfEvent,
//   this.eventTime,
//     this.venue,
//     this.eventDescription,
//     this.posterDescription,
//     this.networkPosterImage,
//     this.pickedPosterImage,
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(padding: const EdgeInsets.only(bottom: 100),
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//             color: Theme.of(context).cardColor,
//           ),
//           margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeLarge),
//           child:  Column(mainAxisSize:  MainAxisSize.min, children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               Text("Event Form Preview", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
//               InkWell(
//                 onTap: ()=> Get.back(),
//                 child: Icon(Icons.clear, color: Theme.of(context).hintColor, size: 20,),
//               )
//             ],),
//             const SizedBox(height: Dimensions.paddingSizeSmall,),
//             SizedBox(
//               height: Get.size.height * 0.3,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Padding(padding: const EdgeInsets.only(bottom: 50),
//                     child: AspectRatio(
//                       aspectRatio: 16/9,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//                             color: Theme.of(context).hintColor.withOpacity(0.1),
//                             border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.2))
//                         ),
//                         padding: const EdgeInsets.only(bottom: 25),
//                         child: pickedPosterImage != null && pickedPosterImage!.isNotEmpty ?
//                         Image.file(File(pickedPosterImage!), fit: BoxFit.cover) : networkPosterImage != null && networkPosterImage!.isNotEmpty ?
//                         CustomImage(
//                           image: networkPosterImage,
//                           fit: BoxFit.cover,
//                         ) : const SizedBox(),
//                       ),
//                     ),
//                   ),
//
//                   Positioned( bottom: 0,left: 0,right: 0, child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//                       color: Theme.of(context).cardColor,
//                       boxShadow: cardShadow,
//                     ),
//                     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                     child: Row( children: [
//                       Expanded(
//                         child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
//                           eventName == null || eventName!.isEmpty ?
//                           Container(
//                             height: 17, width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                               color: Theme.of(context).hintColor.withOpacity(0.1),
//                             ),
//                           )
//                               :
//                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                             Expanded(
//                               child: Text(eventName!, maxLines: 1, overflow: TextOverflow.ellipsis,
//                                 style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),
//                               ),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeDefault),
//                             Container(
//                               padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               child: const Icon(Icons.favorite_outlined, color: Colors.white),
//                             ),
//                           ]),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                           institutionName == null || institutionName!.isEmpty ? Container(
//                             height: 17, width: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                               color: Theme.of(context).hintColor.withOpacity(0.1),
//                             ),
//                           ): Text(institutionName!, maxLines: 2, overflow: TextOverflow.ellipsis, style: ubuntuRegular.copyWith(
//                             color: Theme.of(context).hintColor,
//                           ),),
//                           const SizedBox(height: Dimensions.paddingSizeDefault),
//                         ]),
//                       ),
//
//                       const SizedBox(width: Dimensions.paddingSizeLarge,),
//                     ],),
//                   ))
//                 ],
//               ),
//             ),
//
//           ],),
//         ),
//       ),
//     );
//   }
// }

class PreviewProviderEventWidget extends StatelessWidget {
  final String? eventName;
  final String? institutionName;
  final String? contactNo;
  final String? typeOfEvent;
  final String? eventTime;
  final String? venue;
  final String? eventDescription;
  final String? posterDescription;
  final String? networkPosterImage;
  final String? pickedPosterImage;

  const PreviewProviderEventWidget({
    super.key,
    this.eventName,
    this.institutionName,
    this.contactNo,
    this.typeOfEvent,
    this.eventTime,
    this.venue,
    this.eventDescription,
    this.posterDescription,
    this.networkPosterImage,
    this.pickedPosterImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: Theme.of(context).cardColor,
          ),
          margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Event Form Preview",
                    style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.clear,
                      color: Theme.of(context).hintColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              // Image and Event Info Section
              SizedBox(
                height: Get.size.height * 0.3,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Poster Image Display
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                            color: Theme.of(context).hintColor.withOpacity(0.1),
                            border: Border.all(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                            ),
                          ),
                          padding: const EdgeInsets.only(bottom: 25),
                          child: pickedPosterImage != null && pickedPosterImage!.isNotEmpty
                              ? Image.file(File(pickedPosterImage!), fit: BoxFit.cover)
                              : networkPosterImage != null && networkPosterImage!.isNotEmpty
                              ? CustomImage(
                            image: networkPosterImage,
                            fit: BoxFit.cover,
                          )
                              : const SizedBox(),
                        ),
                      ),
                    ),

                    // Event Name and Institution Details
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                          color: Theme.of(context).cardColor,
                          boxShadow: cardShadow,
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Event Name
                                  eventName == null || eventName!.isEmpty
                                      ? Container(
                                    height: 17,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                      color: Theme.of(context).hintColor.withOpacity(0.1),
                                    ),
                                  )
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          eventName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: ubuntuBold.copyWith(
                                            fontSize: Dimensions.fontSizeLarge,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeDefault),
                                      Container(
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: const Icon(
                                          Icons.favorite_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                  // Institution Name
                                  institutionName == null || institutionName!.isEmpty
                                      ? Container(
                                    height: 17,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                      color: Theme.of(context).hintColor.withOpacity(0.1),
                                    ),
                                  )
                                      : Text(
                                    institutionName!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: ubuntuRegular.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),

                                  // Contact Number
                                  Text(
                                    "Contact: ${contactNo ?? 'N/A'}",
                                    style: ubuntuRegular.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                  // Event Type and Time
                                  if (typeOfEvent != null && typeOfEvent!.isNotEmpty)
                                    Text(
                                      "Type: $typeOfEvent",
                                      style: ubuntuRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  if (eventTime != null && eventTime!.isNotEmpty)
                                    Text(
                                      "Time: $eventTime",
                                      style: ubuntuRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),

                                  // Venue and Description
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  Text(
                                    "Venue: ${venue ?? 'N/A'}",
                                    style: ubuntuRegular.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  if (eventDescription != null && eventDescription!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                      child: Text(
                                        eventDescription!,
                                        style: ubuntuRegular.copyWith(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
