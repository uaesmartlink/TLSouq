import 'dart:async';

import 'package:TLSouq/src/screen/cart/google_map_screen.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../_route/routes.dart';
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
  LatLng initialPosition;
  final phoneCode = "971";
  CountryListModel countryListModel;

  StateListModel stateListModel;
  GetCityModel cityModel;
  ShippingAddressModel shippingAddressModel;
  Position position;

  AddAddress({
    Key? key,
    required this.initialPosition,
    required this.countryListModel,
    required this.stateListModel,
    required this.cityModel,
    required this.shippingAddressModel,
    required this.position,
  }) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddress();
}

class _AddAddress extends State<AddAddress> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final currencyConverterController = Get.find<CurrencyConverterController>();

  // final postalCodeController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  List<Marker> markers = [];
  String? token = LocalDataHelper().getUserToken();

  String? phoneCode = "971";
  dynamic selectPickUpAddress;
  dynamic _selectedCountry; // Option 2
  dynamic _selectedState; // Option 2// Option 2
  dynamic _selectedCity; // Option 2
  bool selectedLocation = false;

  @override
  void initState() {
    super.initState();
  }

  Future getCountryList() async {
    widget.countryListModel = await Repository().getCountryList();
    setState(() {});
  }

  Future getStateList(int? countryId) async {
    widget.stateListModel =
        await Repository().getStateList(countryId: countryId);
    setState(() {});
  }

  Future getShippingAddress() async {
    widget.shippingAddressModel = await Repository().getShippingAddress();
    setState(() {});
  }

  Future getCityList(int? stateId) async {
    widget.cityModel = await Repository().getCityList(stateId: stateId);
    setState(() {});
  }

  void _getCurrentLocation() async {
    widget.position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      widget.initialPosition =
          LatLng(widget.position.latitude, widget.position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("----00----");
    print(widget.initialPosition);
    print(widget.position.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //toolbarHeight: 50.h,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20.r,
          ),

          onPressed: () {
            Get.back();
          }, // null disables the button
        ),
        centerTitle: false,
        title: Text(
          AppTags.addAddress.tr,
          style: AppThemeData.headerTextStyle_16,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(children: [
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
                            widget.cityModel.data!.cities = [];
                          });
                        },
                        items: widget.countryListModel.data!.countries!
                            .map((country) {
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
                  widget.stateListModel.data != null
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
                                    widget.cityModel.data!.cities = [];
                                  },
                                );
                              },
                              items: widget.stateListModel.data!.states!
                                  .map((state) {
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
                                    widget.cityModel.data!.cities = [];
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
                      widget.cityModel.data != null
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
                                  items: widget.cityModel.data!.cities!
                                      .map((city) {
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
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: (!selectedLocation)
                                  ? Text(
                                      AppTags.selectLocation.tr,
                                      style: AppThemeData.hintTextStyle_13,
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(
                                      "Selected",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp),
                                      textAlign: TextAlign.left,
                                    ),
                              onTap: () async {
                                LatLng result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapSample(
                                      initialPosition: widget.initialPosition,
                                      position: widget.position,
                                    ),
                                  ),
                                );
                                setState(() {
                                  selectedLocation = true;
                                  widget.initialPosition = result;
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 8.h,
                  ),
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
                      controller: addressController,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.name,
                      validator: (value) => textFieldValidator(
                        AppTags.name.tr,
                        addressController,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: AppThemeData.hintTextStyle_13,
                        hintText: AppTags.streetAddress.tr,
                        contentPadding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                          bottom: 5.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
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
                    lat: widget.initialPosition.latitude,
                    lng: widget.initialPosition.longitude,
                  )
                      .then((value) {
                    Navigator.pop(context);
                  });
                }
              },

              child: Container(
                alignment: Alignment.bottomRight,
                width: 80.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF31478f),
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
                        ? TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 13.sp,
                      overflow: TextOverflow.clip,
                    )
                        : TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 10.sp,
                      overflow: TextOverflow.clip,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  textFieldValidator(name, textController) {
    if (textController.text.isEmpty) {
      return "$name ${AppTags.required.tr}";
    }
  }
}
