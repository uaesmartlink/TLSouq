import 'dart:async';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/currency_converter_controller.dart';
import '../../data/local_data_helper.dart';
import 'package:TLSouq/src/utils/app_tags.dart';
import '../../models/shipping_address_model/country_list_model.dart';
import '../../models/shipping_address_model/get_city_model.dart';
import '../../models/shipping_address_model/shipping_address_model.dart';
import '../../models/shipping_address_model/state_list_model.dart';
import '../../servers/repository.dart';
import '../../utils/app_theme_data.dart';

import 'package:TLSouq/src/utils/responsive.dart';

import 'package:flutter/services.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddress();
}

class _AddAddress extends State<AddAddress> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  // final postalCodeController = TextEditingController();
  final addressController = TextEditingController();
  final currencyConverterController = Get.find<CurrencyConverterController>();
  bool isSelectPickup = false;
  bool isSelectBilling = true;
  int? shippingIndex = 0;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng _initialPosition = LatLng(25.206450, 55.272896);
  List<Marker> markers = [];
  String? token = LocalDataHelper().getUserToken();

  String? phoneCode = "971";
  dynamic selectPickUpAddress;
  dynamic _selectedCountry; // Option 2
  dynamic _selectedState; // Option 2// Option 2
  dynamic _selectedCity; // Option 2

  @override
  void initState() {
    getCountryList();
    getShippingAddress();
    _getCurrentLocation();
    super.initState();
  }

  CountryListModel countryListModel = CountryListModel();

  Future getCountryList() async {
    countryListModel = await Repository().getCountryList();
    setState(() {});
  }

  ShippingAddressModel shippingAddressModel = ShippingAddressModel();

  Future getShippingAddress() async {
    shippingAddressModel = await Repository().getShippingAddress();
    setState(() {});
  }

  StateListModel stateListModel = StateListModel();

  Future getStateList(int? countryId) async {
    stateListModel = await Repository().getStateList(countryId: countryId);
    setState(() {});
  }

  GetCityModel cityModel = GetCityModel();

  Future getCityList(int? stateId) async {
    cityModel = await Repository().getCityList(stateId: stateId);
    setState(() {});
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppTags.addAddress.tr,
          style: isMobile(context)
              ? AppThemeData.headerTextStyle_16
              : AppThemeData.headerTextStyle_14,
        ),
      ),
      body: Column(children: [
        SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.zero,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTags.name.tr,
                  style: AppThemeData.titleTextStyle_13,
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 42.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffF4F4F4)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
                    ),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    validator: (value) => textFieldValidator(
                      AppTags.name.tr,
                      nameController,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppTags.name.tr,
                      hintStyle: AppThemeData.hintTextStyle_13,
                      contentPadding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                        bottom: 5.h,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10.h),
                // Text(
                //   AppTags.email.tr,
                //   style: AppThemeData.titleTextStyle_13,
                // ),
                // SizedBox(height: 8.h),
                // Container(
                //   height: 42.h,
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.symmetric(horizontal: 4.w),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: const Color(0xffF4F4F4)),
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(5.r),
                //     ),
                //   ),
                //   child: TextFormField(
                //     controller: emailController,
                //     maxLines: 1,
                //     textAlign: TextAlign.left,
                //     keyboardType: TextInputType.emailAddress,
                //     validator: (value) => textFieldValidator(
                //       AppTags.email.tr,
                //       emailController,
                //     ),
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText: AppTags.email.tr,
                //       hintStyle: AppThemeData.hintTextStyle_13,
                //       contentPadding: EdgeInsets.only(
                //         left: 8.w,
                //         right: 8.w,
                //         bottom: 5.h,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 10.h),
                Text(
                  AppTags.phone.tr,
                  style: AppThemeData.titleTextStyle_13,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  height: 42.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 12.w, right: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffF4F4F4)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: CountryPickerDropdown(
                          isFirstDefaultIfInitialValueNotProvided: false,
                          initialValue: 'AE',
                          isExpanded: true,
                          itemBuilder: (Country country) => Row(
                            children: <Widget>[
                              CountryPickerUtils.getDefaultFlagImage(country),
                              Text("+${country.phoneCode}"),
                            ],
                          ),
                          onValuePicked: (Country country) {
                            setState(() {
                              phoneCode = country.phoneCode;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) => textFieldValidator(
                            AppTags.phone.tr,
                            phoneController,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 8.w,
                              right: 8.w,
                              bottom: 5.h,
                            ),
                            border: InputBorder.none,
                            hintText: AppTags.phone.tr,
                            hintStyle: AppThemeData.hintTextStyle_13,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppTags.country.tr,
                  style: AppThemeData.titleTextStyle_13,
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 42.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 12.w, right: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffF4F4F4)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text(
                        AppTags.selectCountry.tr,
                        style: AppThemeData.hintTextStyle_13,
                      ),
                      value: _selectedCountry,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                          cityModel.data!.cities = [];
                        });
                      },
                      items: countryListModel.data!.countries!.map((country) {
                        return DropdownMenuItem(
                          onTap: () async {
                            await getStateList(country.id);
                            setState(() {});
                          },
                          value: country.id,
                          child: Text(country.name.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  AppTags.state.tr,
                  style: AppThemeData.titleTextStyle_13,
                ),
                SizedBox(
                  height: 8.h,
                ),
                stateListModel.data != null
                    ? Container(
                        height: 42.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12.w, right: 4.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffF4F4F4)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text(
                              AppTags.selectState.tr,
                              style: AppThemeData.hintTextStyle_13,
                            ),
                            value: _selectedState,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  print("_selectedCity $_selectedCity");
                                  _selectedState = newValue!;
                                  _selectedCity = null;
                                  cityModel.data!.cities = [];
                                },
                              );
                            },
                            items: stateListModel.data!.states!.map((state) {
                              return DropdownMenuItem(
                                onTap: () async {
                                  await getCityList(state.id);
                                  setState(() {});
                                },
                                value: state.id,
                                child: Text(state.name.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : Container(
                        height: 42.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12.w, right: 4.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffF4F4F4)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text(AppTags.selectState.tr,
                                style: AppThemeData.hintTextStyle_13),
                            value: _selectedState,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  print("@@@ _selectedCity $_selectedCity");
                                  _selectedState = newValue!;
                                  _selectedCity = null;
                                  cityModel.data!.cities = [];
                                },
                              );
                            },
                            items: null,
                          ),
                        ),
                      ),
                SizedBox(height: 16.r),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTags.city.tr,
                      style: AppThemeData.titleTextStyle_13,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    cityModel.data != null
                        ? Container(
                            height: 42.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 12.w, right: 4.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  AppTags.selectCity.tr,
                                  style: AppThemeData.hintTextStyle_13,
                                ),
                                value: _selectedCity,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCity = newValue;
                                  });
                                },
                                items: cityModel.data!.cities!.map((city) {
                                  return DropdownMenuItem(
                                    onTap: () {},
                                    value: city.id,
                                    child: Text(city.name.toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        : Container(
                            height: 50.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 12.w, right: 4.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(AppTags.selectCity.tr,
                                      style: AppThemeData.hintTextStyle_13),
                                  value: _selectedCity,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedCity = newValue;
                                    });
                                  },
                                  items: null),
                            ),
                          ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    AppTags.location.tr,
                    style: AppThemeData.titleTextStyle_13,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 12.w, right: 4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffF4F4F4)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      ),
                    ),
                    child: Container(
                      child: Text(
                        AppTags.add.tr,
                        style: AppThemeData.hintTextStyle_13,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ]),
                /*         SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          AppTags.postalCode.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),*/
                SizedBox(
                  height: 8.h,
                ),
                /*    Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextFormField(
                            controller: postalCodeController,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            validator: (value) => textFieldValidator(
                              AppTags.postalCode.tr,
                              postalCodeController,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppTags.postalCode.tr,
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding:  EdgeInsets.only(
                                left: 8.w,
                                right: 8.w,
                                bottom: 5.h,
                              ),
                            ),
                          ),
                        ),*/
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppTags.address.tr,
                  style: AppThemeData.titleTextStyle_13,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  height: 50.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 12.w,
                    right: 4.w,
                    top: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffF4F4F4)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
                    ),
                  ),
                  child: TextFormField(
                    controller: addressController,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    validator: (value) => textFieldValidator(
                      AppTags.address.tr,
                      addressController,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppTags.streetAddress.tr,
                      hintStyle: AppThemeData.hintTextStyle_13,
                      contentPadding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, bottom: 15.h, right: 15.w),
          child: InkWell(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                Get.back();
                await Repository()
                    .postCreateAddress(
                      name: nameController.text.toString(),
                      // email: emailController.text.toString(),
                      phoneNo: "+$phoneCode ${phoneController.text.toString()}",
                      countryId: _selectedCountry,
                      stateId: _selectedState,
                      cityId: _selectedCity,
                      // postalCode: postalCodeController.text.toString(),
                      address: addressController.text.toString(),
                    )
                    .then((value) => getShippingAddress());
              }
            },
            child: Container(
              alignment: Alignment.bottomRight,
              width: 80.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffF4F4F4)),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.r),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  AppTags.add.tr,
                  style: isMobile(context)
                      ? AppThemeData.buttonTextStyle_13
                      : AppThemeData.buttonTextStyle_10Tab,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  textFieldValidator(name, textController) {
    if (textController.text.isEmpty) {
      return "$name ${AppTags.required.tr}";
    }
  }
}
