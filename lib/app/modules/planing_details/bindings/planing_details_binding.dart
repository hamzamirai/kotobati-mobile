import 'package:get/get.dart';

import '../controllers/planing_details_controller.dart';

class PlaningDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaningDetailsController>(
      () => PlaningDetailsController(),
    );
  }
}
