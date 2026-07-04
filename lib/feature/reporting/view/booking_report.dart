import 'package:purplestage_provider/utils/core_export.dart';
import 'package:get/get.dart';

class BookingReport extends StatefulWidget {
  const BookingReport({super.key});

  @override
  State<BookingReport> createState() => _BookingReportState();
}

class _BookingReportState extends State<BookingReport> {

  @override
  void initState() {
    super.initState();
    Get.find<BookingReportController>().getBookingReportData(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingReportController>(builder: (bookingReportController){
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor.withOpacity(0.97),
        appBar: ReportAppBarView(title: 'booking_report'.tr, fromPage: 'booking', isFiltered: bookingReportController.isFiltered,),
        body:  bookingReportController.bookingReportModel !=null ? CustomScrollView(
          controller: bookingReportController.scrollController,
          slivers: [

            bookingReportController.isFiltered ? const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: BookingReportFilteredWidget(),
              ),
            ) : const SliverToBoxAdapter(child: SizedBox()),

            const SliverToBoxAdapter(child: BookingReportStatistics()),

            const SliverToBoxAdapter(child: BookingReportBarChart()),

            SliverToBoxAdapter(child: BookingReportListView(
              bookingFilterData: bookingReportController.bookingReportFilterData,
            ))
          ],
        )  : const BookingReportShimmer()
      );
    });
  }
}


