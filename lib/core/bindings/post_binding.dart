import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/features/create_post/controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostController());
  }
}
