// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kitchen_partners/widgets/common_button2.dart';

import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field_view.dart';
import '../../widgets/custom_appbar.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
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
                      'نسيت كلمة المرور',
                      style: TextStyles(context).getTitle2Style().copyWith(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 55,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "نسيت كلمة المرور",
                        style: TextStyles(context).getTitleStyle(),
                      ),
                    ),
                    Text(
                      "الرجاء ادخال البريد الالكتروني المسجل, سوف يتم ارسال رسالة حتى تتمكن من استعادة كلمة المرور.",
                      style: TextStyles(context).getSubTitleStyle().copyWith(
                            color: AppTheme.lightGrayTextColor,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 16),
                      child: Text(
                        "البريد الالكتروني",
                        style: TextStyles(context).getTitle2Style().copyWith(
                              color: AppTheme.primaryTextColor,
                            ),
                      ),
                    ),
                    CommonTextFieldView(
                      hintText: "    mohabdullah@gmail.com",
                      controller: emailController,
                      onChanged: (value) {
                        value = emailController.text;
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Icon(
                        Icons.close,
                        color: AppTheme.lightGrayTextColor,
                      ),
                    ),
                    CommonButton2(
                      padding: EdgeInsets.only(bottom: 32, top: 32),
                      buttonText: "استعادة كلمة المرور",
                      radius: 16,
                      // onTap: () {
                      //   setState(() {
                      //     NavigationServices(context).gotoResetEmailScreen();
                      //   });
                      // },
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
