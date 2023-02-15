import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../_route/routes.dart';
import 'package:TLSouq/src/utils/images.dart';
import 'package:TLSouq/src/utils/app_tags.dart';

class PreSignUp extends StatelessWidget {
  const PreSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCard(
              title: "Individual",
              icon: "individual",
              callback: () => {
                Get.toNamed(
                  Routes.signUp,
                  arguments: AppTags.customerType,
                )
              },
            ),
            CustomCard(
              title: "Company",
              icon: "company",
              callback: () => {
                Get.toNamed(
                  Routes.signUp,
                  arguments: AppTags.companyType,
                )
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback callback;

  const CustomCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: callback,
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/$icon.svg",
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10, // <-- SEE HERE
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
