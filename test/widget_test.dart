// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:TLSouq/src/models/video_shopping_details_model.dart';
import 'package:TLSouq/src/utils/constants.dart';


void main() {
  test('', () async {
    final response = await http.get(Uri.parse("https://TLSouq.spagreen.net/api/v100/video-shops-details/asd?token=null&lang=null&curr=null"));
    try {
      var data = json.decode(response.body);
      var videoShoppingDetailsModel = VideoShoppingDetailsModel.fromJson(data);
      printLog("Video Type => ${videoShoppingDetailsModel.data!.video!.videoType}");
      return videoShoppingDetailsModel;
    } catch (e) {
      printLog("inside catch");
      throw Exception(e);
    }

  });
}
