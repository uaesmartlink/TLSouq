import 'package:get/get.dart';
import 'package:TLSouq/src/controllers/cart_content_controller.dart';
import 'package:TLSouq/src/controllers/category_content_controller.dart';
import 'package:TLSouq/src/controllers/dashboard_controller.dart';
import 'package:TLSouq/src/controllers/favourite_controller.dart';
import 'package:TLSouq/src/controllers/home_screen_controller.dart';
import 'package:TLSouq/src/controllers/order_history_controller.dart';
import 'package:TLSouq/src/controllers/profile_content_controller.dart';
import 'package:TLSouq/src/controllers/tracking_order_controller.dart';


class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryContentController>(
      () => CategoryContentController(),
      fenix: true,
    );
    Get.lazyPut<ProfileContentController>(
      () => ProfileContentController(),
      fenix: true,
    );

    Get.put<DashboardController>(
      DashboardController(),
      permanent: true,
    );
    Get.put<HomeScreenController>(
      HomeScreenController(),
      permanent: true,
    );
    Get.put<CartContentController>(
      CartContentController(),
    );
    Get.put<FavouriteController>(
      FavouriteController(),
    );
    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
      fenix: true,
    );
    Get.lazyPut<TrackingOrderController>(
      () => TrackingOrderController(),
      fenix: true,
    );

  }
}
