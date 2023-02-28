import 'package:flutter/material.dart';

class Config {
  // copy your server url from admin panel
  static String apiServerUrl = "https://wared.smart-link.ae/api";
  // copy your api key from admin panel
  static String apiKey = "5XI9GCLSIUSF8DKL";

  //enter onesignal app id below
  static String oneSignalAppId = "d9ab061b-22dd-4eb6-9beb-c972ef7a0736";
  // find your ios APP id from app store
  static const String iosAppId = "";
  static const bool enableGoogleLogin = true;
  static const bool enableFacebookLogin = true;
  // if "groceryCartMode = true" then product will be added to cart directly
  static const bool groceryCartMode = false;

  static var supportedLanguageList = [
    const Locale("en", "US"),
    // const Locale("bn", "BD"),
    const Locale("ar", "SA"),
  ];
  static const String initialCountrySelection = "US";

}
