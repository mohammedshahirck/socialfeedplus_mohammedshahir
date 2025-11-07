import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/controllers/feed_controller.dart';


class FeedBinding extends Bindings {
  @override  void dependencies() {
    Get.put(FeedController());
  }
}
