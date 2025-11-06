import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
