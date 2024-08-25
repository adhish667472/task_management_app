import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management_app/common/utils/constants.dart';
import 'package:task_management_app/common/widgets/appstyle.dart';
import 'package:task_management_app/common/widgets/custom_otn_btn.dart';
import 'package:task_management_app/common/widgets/custom_text.dart';
import 'package:task_management_app/common/widgets/height_spacer.dart';
import 'package:task_management_app/common/widgets/reusable_text.dart';
import 'package:task_management_app/common/widgets/showDialogue.dart';
import 'package:task_management_app/features/auth/controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();

  Country country = Country(
      //country code
      phoneCode: "977",
      countryCode: "NP",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Nepal",
      example: "Nepal",
      displayName: "Nepal",
      displayNameNoCountryCode: "NP",
      e164Key: "");

  sendCodeToUser() {
    if (phone.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please enter your phone number");
    } else if (phone.text.length < 10) {
      return showAlertDialog(
          context: context, message: "Your number is too short");
    } else {
      print('+${country.phoneCode}${phone.text}');
      ref.read(authControllerProvider).sendSms(
          context: context,
          phone: '+${country.phoneCode}${phone.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                "assets/images/todo.png",
                width: 300,
              ),
            ),
            const HeightSpacer(hieght: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.w),
              child: ReusableText(
                  text: "Please enter your phone number",
                  style: appstyle(17, AppConst.kLight, FontWeight.w500)),
            ),
            const HeightSpacer(hieght: 20),
            Center(
              child: CustomTextField(
                controller: phone,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                              backgroundColor: AppConst.kBkDark,
                              bottomSheetHeight: AppConst.kHeight * 0.6,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppConst.kRadius),
                                  topRight: Radius.circular(AppConst.kRadius))),
                          onSelect: (code) {
                            setState(() {
                              country = code;
                            });
                            
                          });
                    },
                    child: ReusableText(
                        text: "${country.flagEmoji} + ${country.phoneCode}",
                        style: appstyle(18, AppConst.kBkDark, FontWeight.bold)),
                  ),
                ),
                keyboardType: TextInputType.number,
                hintText: "Enter phone number",
                hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),
              ),
            ),
            const HeightSpacer(hieght: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOtlnBtn(
                onTap: () {
                  sendCodeToUser();
                },
                width: AppConst.kWidth * 0.9,
                height: AppConst.kHeight * 0.075,
                color: AppConst.kBkDark,
                color2: AppConst.kLight,
                text: "Send Code",
              ),
            ),
          ],
        ),
      )),
    );
  }
}
