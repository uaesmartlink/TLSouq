import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_theme_data.dart';


class ShimmerInvoice extends StatelessWidget {
  const ShimmerInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    //height: size.height/4.5,
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      boxShadow: [
                        BoxShadow(
                          color: AppThemeData.boxShadowColor.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10.r,
                          offset: const Offset(
                              0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  height: 22.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                ),
                              ),
                              Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.r))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w,right: 8.w),
                              child: Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  height: 20.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w,right: 8.w),
                              child: Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  height: 20.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                   SizedBox(height: 10.h),
                  Container(
                    //height: size.height/4.5,
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      boxShadow: [
                        BoxShadow(
                          color: AppThemeData.boxShadowColor.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10.r,
                          offset: const Offset(
                              0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 22.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4.r))),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10.r))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.w,right: 8.w),
                                child: Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 20.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4.r))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4.r))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.w,right: 8.w),
                                child: Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 20.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4.r))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4.r))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h,),
                  //bottom section

                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 30,
                        blurRadius: 5,
                        color: AppThemeData.boxShadowColor.withOpacity(0.01),
                        offset: const Offset(0, 15))
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width / 1.6,
                            height: size.height / 18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
