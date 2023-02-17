import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  String? languageCode;
  String? countryCode;
  String? currCode;
  Future<StorageService> init() async {
    await GetStorage.init();
    languageCode = GetStorage().read('languageCode');
    countryCode = GetStorage().read('countryCode');
    write("currCode", "AED");
    currCode = GetStorage().read('currCode');
    return this;
  }
  void write(String key, dynamic value) {
    GetStorage().write(key, value);
  }
}