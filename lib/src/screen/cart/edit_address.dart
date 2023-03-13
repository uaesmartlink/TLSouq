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
import '../../models/edit_view_model.dart';
import '../../models/shipping_address_model/country_list_model.dart';
import '../../models/shipping_address_model/get_city_model.dart';
import '../../models/shipping_address_model/shipping_address_model.dart';
import '../../models/shipping_address_model/state_list_model.dart';
import '../../servers/repository.dart';
import '../../utils/app_theme_data.dart';

import 'package:TLSouq/src/utils/responsive.dart';

import 'package:flutter/services.dart';

class EditAddress extends StatefulWidget {
  LatLng initialPosition;
  final phoneCode = "971";
  CountryListModel countryListModel;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController addressController;
  StateListModel stateListModel;
  GetCityModel cityModel;
  ShippingAddressModel shippingAddressModel;
  EditViewModel editViewModel;
  Position position;
  int addressId;
  dynamic selectedCountry; // Option 2
  dynamic selectedState; // Option 2// Option 2
  dynamic selectedCity; // Option 2
  EditAddress({
    Key? key,
    required this.initialPosition,
    required this.countryListModel,
    required this.stateListModel,
    required this.cityModel,
    required this.shippingAddressModel,
    required this.position,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.editViewModel,
    required this.addressId,
    required this.selectedCity,
    required this.selectedState,
    required this.selectedCountry,
  }) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddress();
}

class _EditAddress extends State<EditAddress> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final currencyConverterController = Get.find<CurrencyConverterController>();

  // final postalCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<Marker> markers = [];
  String? token = LocalDataHelper().getUserToken();

  String? phoneCode = "971";
  dynamic selectPickUpAddress;

  bool selectedLocation = true;

  @override
  void initState() {
    print("SSSSs");
    print(widget.editViewModel.data!.address!.longitude);
    print(widget.editViewModel.data!.address!.latitude);
    print(widget.editViewModel.data!.address!.country!);
    print(widget.editViewModel.data!.address!.state!);
    print(widget.editViewModel.data!.address!.phoneNo!);
    print(widget.editViewModel.data!.address!.name!);
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
          AppTags.editAddress.tr,
          style: AppThemeData.headerTextStyle_16,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTags.name.tr,
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
                  child: TextField(
                    controller: widget.nameController,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      // label: Text(editViewModel.data!.address!.name.toString()),
                      border: InputBorder.none,
                      hintText:
                          widget.editViewModel.data!.address!.name.toString(),
                      hintStyle: AppThemeData.hintTextStyle_13,
                      contentPadding:
                          EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h),
                    ),
                  ),
                ),
                // SizedBox(height: 16.h),
                // Text(
                //   AppTags.email.tr,
                //   style: AppThemeData.titleTextStyle_13,
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
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
                //   child: TextField(
                //     controller: emailController,
                //     maxLines: 1,
                //     textAlign: TextAlign.left,
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText:
                //           editViewModel.data!.address!.email.toString(),
                //       hintStyle: AppThemeData.hintTextStyle_13,
                //       contentPadding: EdgeInsets.only(
                //           left: 8.w, right: 8.w, bottom: 8.h),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 16.h),
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
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (Country country) {
                            setState(() {
                              phoneCode = country.phoneCode;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: TextField(
                          controller: widget.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget
                                .editViewModel.data!.address!.phoneNo
                                .toString(),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  AppTags.country.tr,
                  style: AppThemeData.titleTextStyle_13,
                ),
                SizedBox(
                  height: 16.h,
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Text(
                          widget.editViewModel.data!.address!.country!
                              .toString(),
                          style: AppThemeData.hintTextStyle_13,
                        ),
                      ),
                      // Not necessary for Option 1
                      value: widget.selectedCountry,
                      onChanged: (newValue) {
                        setState(() {
                          widget.selectedCountry = newValue;
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
                            value: widget.selectedState,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  widget.selectedState = newValue!;
                                  widget.selectedCity = null;
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
                            value: widget.selectedState,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  widget.selectedState = newValue!;
                                  widget.selectedCity = null;
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
                                value: widget.selectedCity,
                                onChanged: (newValue) {
                                  setState(() {
                                    widget.selectedCity = newValue;
                                  });
                                },
                                items:
                                    widget.cityModel.data!.cities!.map((city) {
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
                                  value: widget.selectedCity,
                                  onChanged: (newValue) {
                                    setState(() {
                                      widget.selectedCity = newValue;
                                    });
                                  },
                                  items: null),
                            ),
                          ),
                  ],
                ),
                /*         SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          AppTags.postalCode.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),*/
                SizedBox(
                  height: 10,
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
                  height: 16.h,
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
                    controller: widget.addressController,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    validator: (value) => textFieldValidator(
                      AppTags.name.tr,
                      widget.addressController,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.editViewModel.data!.address!.address!
                          .toString(),
                      hintStyle: AppThemeData.hintTextStyle_13,
                      contentPadding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                        bottom: 10.h,
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
          Padding(
            padding: EdgeInsets.only(left: 15.w, bottom: 15.h, right: 15.w),
            child: InkWell(
              onTap: () async {
                await Repository()
                    .updateEditAddress(
                      name: widget.nameController.text.isNotEmpty
                          ? widget.nameController.text.toString()
                          : widget.editViewModel.data!.address!.name.toString(),
                      // email: emailController.text.isNotEmpty
                      //     ? emailController.text.toString()
                      //     : editViewModel.data!.address!.email
                      //         .toString(),
                      phoneNo: widget.phoneController.text.isNotEmpty
                          ? "+$phoneCode ${widget.phoneController.text.toString()}"
                          : widget.editViewModel.data!.address!.phoneNo
                              .toString(),
                      countryId: widget.selectedCountry ??
                          int.parse(widget.editViewModel.data!.address!
                              .addressIds!.countryId
                              .toString()),
                      stateId: widget.selectedState ??
                          int.parse(widget
                              .editViewModel.data!.address!.addressIds!.stateId
                              .toString()),
                      cityId: widget.selectedCity ??
                          int.parse(widget
                              .editViewModel.data!.address!.addressIds!.cityId
                              .toString()),
                      // postalCode: postalCodeController.text.isNotEmpty?postalCodeController.text.toString():editViewModel.data!.address!.postalCode.toString(),
                      address: widget.addressController.text.isNotEmpty
                          ? widget.addressController.text.toString()
                          : widget.editViewModel.data!.address!.address
                              .toString(),
                      addressId: widget.addressId!,
                      lng: widget.initialPosition.longitude,
                      lat: widget.initialPosition.latitude,
                    )
                    .then((value) => getShippingAddress());
                Get.back();
              },
              child: Container(
                alignment: Alignment.bottomRight,
                width: 120.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF31478f),
                  border: Border.all(
                    color: const Color(0xffF4F4F4),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.r),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    AppTags.edit.tr,
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

  Widget _buildDropdownItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text("+${country.phoneCode}"),
        ],
      );

  textFieldValidator(name, textController) {
    if (textController.text.isEmpty) {
      return "$name ${AppTags.required.tr}";
    }
  }
}
