import 'package:get/get.dart';
import 'package:TLSouq/src/models/my_wallet_model.dart';
import 'package:TLSouq/src/servers/repository.dart';

class MyWalletController extends GetxController {
  late Rx<MyWalletModel> myWalletModel = MyWalletModel().obs;

  Future getMyWallet() async {
    await Repository().getMyWallet().then((value) {
      myWalletModel.value = value!;
    });
    update();
  }

  @override
  void onInit() {
    getMyWallet();
    super.onInit();
  }
}
