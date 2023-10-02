// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:kitchen_partners/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_button2.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/otp_input_field.dart';

class AccountVerification extends StatefulWidget {
  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  // 4 text editing controllers that associate with the 4 input fields

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomAppBarView(
                leftWidget: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
                centerWidget: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 12,
                    ),
                    Text(
                      'ادخل الرمز',
                      style: TextStyles(context).getTitle2Style().copyWith(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "ادخل الرمز هنا",
                        style: TextStyles(context).getTitleStyle(),
                      ),
                    ),
                    Text(
                      "ادخل الرمز المرسل على بريدك الإلكتروني",
                      style: TextStyles(context).getSubTitleStyle().copyWith(
                            color: AppTheme.lightGrayTextColor,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 48, bottom: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtpInput(_fieldOne, true),
                          OtpInput(_fieldTwo, false),
                          OtpInput(_fieldThree, false),
                          OtpInput(_fieldFour, false)
                        ],
                      ),
                    ),
                    Text(
                      "لم تصلك الرسالة؟ تأكد من صفحة الاعلانات ",
                      style: TextStyles(context).getSubTitleStyle().copyWith(
                            color: AppTheme.lightGrayTextColor,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          ".او البريد المزعج",
                          style:
                              TextStyles(context).getSubTitleStyle().copyWith(
                                    color: AppTheme.lightGrayTextColor,
                                  ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              otp = _fieldOne.text +
                                  _fieldTwo.text +
                                  _fieldThree.text +
                                  _fieldFour.text;
                            });
                            NavigationServices(context)
                                .gotoResendAccountVerificationScreen();
                          },
                          child: Text(
                            "اعد الارسال",
                            style:
                                TextStyles(context).getSubTitleStyle().copyWith(
                                      color: AppTheme.primaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    CommonButton2(
                      padding: EdgeInsets.only(bottom: 16, top: 24),
                      buttonText: "إرسال",
                      radius: 16,
                      onTap: () {
                        NavigationServices(context).gotoHomeScreen();
                      },
                      backgroundColor: AppTheme.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
