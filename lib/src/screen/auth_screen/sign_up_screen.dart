import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:TLSouq/config.dart';
import 'package:TLSouq/src/utils/images.dart';
import '../../data/local_data_helper.dart';
import '../../models/shipping_address_model/state_list_model.dart';
import '../../servers/repository.dart';

import '../../_route/routes.dart';
import '../../controllers/auth_controller.dart';
import 'package:TLSouq/src/utils/app_tags.dart';
import '../../utils/app_theme_data.dart';
import '../../widgets/single_pdf_selector.dart';
import '../../widgets/button_widget.dart';
import 'package:TLSouq/src/utils/responsive.dart';
import '../../widgets/loader/loader_widget.dart';
import '../../widgets/login_edit_textform_field.dart';
import 'package:file_picker/file_picker.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  dynamic _selectedState;
  final AuthController authController = Get.find<AuthController>();
  final String type = Get.arguments;
  late String pathFile = '';

  _SignupScreen() {
    getStateList(231);
  }

  StateListModel? stateListModel = StateListModel();

  Future getStateList(int? countryId) async {
    stateListModel = await Repository().getStateList(countryId: countryId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _ui(context),
            Obx(() => authController.isLoggingIn
                ? const Positioned(height: 50, width: 50, child: LoaderWidget())
                : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _ui(context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 40.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 115.w,
              height: 83.h,
              //color: Colors.green,
              child: Image.asset(Images.logo),
            ),
            SizedBox(height: 15.h),
            Text(
              AppTags.welcome.tr,
              style: AppThemeData.welComeTextStyle_24,
            ),
            SizedBox(height: 6.h),
            Text(
              AppTags.signUpToContinue.tr,
              style: AppThemeData.titleTextStyle_13,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            LoginEditTextField(
              myController: authController.firstNameController,
              keyboardType: TextInputType.text,
              hintText: AppTags.firstName.tr,
              fieldIcon: Icons.person,
              myObscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            LoginEditTextField(
              myController: authController.lastNameController,
              keyboardType: TextInputType.text,
              hintText: AppTags.lastName.tr,
              fieldIcon: Icons.person,
              myObscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            LoginEditTextField(
              myController: authController.emailControllers,
              keyboardType: TextInputType.text,
              hintText: AppTags.emailAddress.tr,
              fieldIcon: Icons.email,
              myObscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => LoginEditTextField(
                myController: authController.passwordControllers,
                keyboardType: TextInputType.text,
                hintText: AppTags.password.tr,
                fieldIcon: Icons.lock,
                myObscureText: authController.passwordVisible.value,
                suffixIcon: InkWell(
                  onTap: () {
                    authController.isVisiblePasswordUpdate();
                  },
                  child: Icon(
                    authController.passwordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppThemeData.iconColor,
                    //size: defaultIconSize,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => LoginEditTextField(
                myController: authController.confirmPasswordController,
                keyboardType: TextInputType.text,
                hintText: AppTags.confirmPassword.tr,
                fieldIcon: Icons.lock,
                myObscureText: authController.confirmPasswordVisible.value,
                suffixIcon: InkWell(
                  onTap: () {
                    authController.isVisibleConfirmPasswordUpdate();
                  },
                  child: Icon(
                    authController.confirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppThemeData.iconColor,
                    //size: defaultIconSize,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            if (type == AppTags.companyType)
              SinglePdfSelector(
                label: "Please Add Your License File",
                authController: authController,
                type: 0,
              ),
            if (type == AppTags.companyType)
              SinglePdfSelector(
                label: "Please Add Your VAT File",
                authController: authController,
                type: 1,
              ),
            /* Padding(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(left: 25),
                    primary: Colors.grey[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result != null) {
                      File? file = File(result.files.single.path!);
                      pathFile = result.files.single.name;
                    } else {
                      return;
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          pathFile == ''
                              ? 'Please Add Your License'
                              : 'Added successfully',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 17,
                        ),
                        child: Icon(
                          color: Colors.grey[700],
                          Icons.upload,
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  //color: Color(0xfff3f3f4),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppThemeData.boxShadowColor.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 30,
                      offset: const Offset(0, 15), // changes position of shadow
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.pin_drop,
                        ),
                        border: InputBorder.none,
                      ),
                      isExpanded: true,
                      hint: Text(
                        AppTags.selectState.tr,
                        style: AppThemeData.hintTextStyle_13,
                      ),
                      value: _selectedState,
                      onChanged: (newValue) {
                        setState(
                          () {
                            _selectedState = newValue;
                          },
                        );
                      },
                      items: (stateListModel!.data != null)
                          ? stateListModel!.data!.states!.map((state) {
                              return DropdownMenuItem(
                                onTap: () async {
                                  setState(() {});
                                },
                                value: state.id,
                                child: Text(state.name.toString()),
                              );
                            }).toList()
                          : [].map((state) {
                              return DropdownMenuItem(
                                onTap: () async {
                                  setState(() {});
                                },
                                value: state.id,
                                child: Text(state.name.toString()),
                              );
                            }).toList()),
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: InkWell(
                onTap: () {
                  authController.signUp(
                    firstName: authController.firstNameController.text,
                    lastName: authController.lastNameController.text,
                    email: authController.emailControllers.text,
                    password: authController.passwordControllers.text,
                    confirmPassword:
                        authController.confirmPasswordController.text,
                    type: type,
                  );
                },
                child: ButtonWidget(buttonTittle: AppTags.signUp.tr),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.dashboardScreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Images.arrowBack),
                  SizedBox(
                    width: 5.h,
                  ),
                  Text(
                    AppTags.backToShopping.tr,
                    style: isMobile(context)
                        ? AppThemeData.categoryTitleTextStyle_12
                        : AppThemeData.categoryTitleTextStyle_9Tab,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (type == AppTags.customerType)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google login button
                    Config.enableGoogleLogin
                        ? Container(
                            height: 48.h,
                            width: 48.w,
                            margin: EdgeInsets.only(right: 15.w),
                            decoration: BoxDecoration(
                              color: AppThemeData.socialButtonColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: InkWell(
                              onTap: () => authController.signInWithGoogle(),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(Images.google),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    //facebook login button
                    Config.enableFacebookLogin
                        ? Container(
                            height: 48.h,
                            width: 48.w,
                            margin: EdgeInsets.only(right: 15.w),
                            decoration: BoxDecoration(
                              color: AppThemeData.socialButtonColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                authController.facebookLogin();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(Images.facebook),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Platform.isIOS
                        ? Container(
                            height: 48.h,
                            width: 48.w,
                            margin: EdgeInsets.only(right: 15.w),
                            decoration: BoxDecoration(
                              color: AppThemeData.socialButtonColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                authController.signInWithApple();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(Images.appleLogo),
                              ),
                            ),
                          )
                        : Container(),
                    LocalDataHelper().isPhoneLoginEnabled()
                        ? Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                                color: AppThemeData.socialButtonColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.phoneRegistration);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(Images.phoneLogin),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTags.iHaveAnAccount.tr,
                  style: AppThemeData.qsTextStyle_12,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.logIn);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    child: Text(
                      AppTags.signIn.tr,
                      style: AppThemeData.qsboldTextStyle_12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                AppTags.signUpTermsAndCondition.tr,
                textAlign: TextAlign.center,
                style: isMobile(context)
                    ? AppThemeData.hintTextStyle_13
                    : AppThemeData.hintTextStyle_10Tab,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ],
    );
  }
}
