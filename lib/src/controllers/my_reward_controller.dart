import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TLSouq/src/models/my_reward_model.dart';
import 'package:TLSouq/src/servers/repository.dart';
import 'package:get_storage/get_storage.dart';

class MyRewardController extends GetxController {
  late Rx<MyRewardModel> myRewardModel = MyRewardModel().obs;
  final TextEditingController?  convertRewardController = TextEditingController();
  var convertedReward = '0.0'.obs;


  var isLoading=false.obs;

  Future getMyReward() async {
    await Repository().getMyReward().then((value) {
        if(value != null) {
          myRewardModel.value = value;
        }
    });
    update();
  }

  Future postConvertReward(String reward) async {
    await Repository().postConvertReward(reward: reward).then((value) {
      isLoading.value = value;
    });
    update();
  }

  @override
  void onInit() {
    convertRewardController!.addListener(() {
      convertedReward.value=convertRewardController!.text;
    });
    getMyReward();
    super.onInit();
  }
}
