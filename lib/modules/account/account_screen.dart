// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_partners/services/firestore.dart';
import 'package:kitchen_partners/widgets/common_button2.dart';
import '../../constants/themes.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_text_field_view.dart';
import '../../widgets/custom_appbar.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController alergicController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController preferredController = TextEditingController();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) => setState(() {
              nameController.text = value.data()!['Name'];
              emailController.text = value.data()!['Email'];
              preferredController.text = value.data()!['Food Preference'];
              alergicController.text = value.data()!['Food alergy'];
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarView(
            centerWidget: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    "الحساب",
                    style: TextStyles(context).getTitle2Style().copyWith(
                        color: AppTheme.primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "الاسم",
                    style: TextStyles(context).getTitle2Style().copyWith(
                          color: AppTheme.primaryTextColor,
                        ),
                  ),
                ),
                CommonTextFieldView(
                  hintText: "    محمد عبدالله",
                  controller: nameController,
                  onChanged: (value) {
                    value = nameController.text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    Icons.close,
                    color: AppTheme.lightGrayTextColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "البريد الإلكتروني",
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
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "المكونات المفضلة",
                    style: TextStyles(context).getTitle2Style().copyWith(
                          color: AppTheme.primaryTextColor,
                        ),
                  ),
                ),
                CommonTextFieldView(
                  hintText: "  جبن",
                  controller: preferredController,
                  onChanged: (value) {
                    value = preferredController.text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    Icons.close,
                    color: AppTheme.lightGrayTextColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "الحساسية ",
                    style: TextStyles(context).getTitle2Style().copyWith(
                          color: AppTheme.primaryTextColor,
                        ),
                  ),
                ),
                CommonTextFieldView(
                  hintText: "    توت, فراولة",
                  controller: alergicController,
                  onChanged: (value) {
                    value = alergicController.text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    Icons.close,
                    color: AppTheme.lightGrayTextColor,
                  ),
                ),
                CommonButton2(
                  padding: EdgeInsets.only(bottom: 24, top: 32),
                  buttonText: "حفظ التعديلات",
                  radius: 16,
                  onTap: () {
                    updateUser(
                            name: nameController.text,
                            email: emailController.text,
                            alergy: alergicController.text,
                            preference: preferredController.text)
                        .then((value) =>
                            {Navigator.pop(context), Navigator.pop(context)});
                  },
                  backgroundColor: AppTheme.primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
