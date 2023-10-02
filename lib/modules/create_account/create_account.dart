// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_partners/modules/sign_in/sign_in.dart';
import 'package:kitchen_partners/widgets/text_widget.dart';
import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field_view.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final allergyController = TextEditingController();
  final foodprefController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    allergyController.dispose();
    foodprefController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //   );
    //   addUserDetails(nameController.text.trim(), emailController.text.trim(),
    //       foodprefController.text.trim(), allergyController.text.trim());
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseFirestore db = FirebaseFirestore.instance;
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String foodallergy = allergyController.text;
    final String foodpref = foodprefController.text;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await db.collection("Users").doc(userCredential.user!.uid).set({
        "Name": name,
        "Email": email,
        "Food alergy": foodallergy,
        "Food Preference": foodpref,
      });

      // addUserDetails(nameController.text.trim(), emailController.text.trim(),
      //     foodprefController.text.trim(), allergyController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignIn(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (nameController.text.isEmpty &&
          emailController.text.isEmpty &&
          passwordController.text.isEmpty) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  title: "خطأ",
                  txtSize: 25.0,
                  txtColor: Theme.of(context).primaryColor,
                  TextAlign: TextAlign.right,
                ),
                content: TextWidget(
                  title: "الرجاء تعبئة جميع المعلومات",
                  txtSize: 20.0,
                  txtColor: Theme.of(context).primaryColor,
                  TextAlign: TextAlign.right,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextWidget(
                      title: "حسناً",
                      txtSize: 18.0,
                      txtColor: Theme.of(context).primaryColor,
                      TextAlign: TextAlign.right,
                    ),
                  ),
                ],
              );
            });
      }
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: TextWidget(
              title: "كلمة المرور ضعيفة",
              txtSize: 18.0,
              txtColor: Color.fromARGB(255, 255, 255, 255),
              TextAlign: TextAlign.right,
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: TextWidget(
              title: "البريد الإلكتروني مستخدم بالفعل",
              txtSize: 18.0,
              txtColor: Color.fromARGB(255, 255, 255, 255),
              TextAlign: TextAlign.right,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 24, bottom: 16),
          child: Stack(children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "إنشاء حساب",
                    style: TextStyles(context).getTitleStyle(),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          " ادخل اسمك, البريد الإلكتروني, كلمة المرور لإنشاء حساب",
                          style:
                              TextStyles(context).getSubTitleStyle().copyWith(
                                    color: AppTheme.lightGrayTextColor,
                                  ),
                        )),
                    Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                NavigationServices(context).gotoSignInScreen();
                              });
                            },
                            child: Text(
                              " لديك حساب بالفعل؟",
                              style: TextStyles(context)
                                  .getSubTitleStyle()
                                  .copyWith(
                                    color: AppTheme.primaryColor,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        "الاسم كامل",
                        style: TextStyles(context).getTitle2Style().copyWith(
                              color: AppTheme.primaryTextColor,
                            ),
                        textAlign: TextAlign.right,
                      ),
                    ),

                    CommonTextFieldView(
                      hintText: "    محمد عبدالله",
                      controller: nameController,
                      onChanged: (value) {
                        value = nameController.text;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
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
                    ),
// //allergy
//                     Padding(
//                       padding: const EdgeInsets.only(top: 24, bottom: 16),
//                       child: Text(
//                         "هل لديك حساسية؟",
//                         style: TextStyles(context).getTitle2Style().copyWith(
//                               color: AppTheme.primaryTextColor,
//                             ),
//                       ),
//                     ),
//                     CommonTextFieldView(
//                       hintText: "    فراولة",
//                       controller: allergyController,
//                       onChanged: (value) {
//                         value = allergyController.text;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 24, bottom: 16),
//                       child: Text(
//                         "هل لديك مكونات مفضلة؟",
//                         style: TextStyles(context).getTitle2Style().copyWith(
//                               color: AppTheme.primaryTextColor,
//                             ),
//                       ),
//                     ),
//                     CommonTextFieldView(
//                       hintText: "    مانجو",
//                       controller: foodprefController,
//                       onChanged: (value) {
//                         value = foodprefController.text;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                     ),

                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        "كلمة المرور",
                        style: TextStyles(context).getTitle2Style().copyWith(
                              color: AppTheme.primaryTextColor,
                            ),
                      ),
                    ),
                    CommonTextFieldView(
                      hintText: "    كلمة المرور",
                      controller: passwordController,
                      onChanged: (value) {
                        value = passwordController.text;
                      },
                      isObscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 16),
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ButtonWidget(
                            btnText: "تسجيل",
                            onPress: register,
                          ),
                        )),
                    Row(
                      children: [
                        Text(
                          "عند إنشاء حساب انت توافق على احكامنا وشروطنا",
                          style:
                              TextStyles(context).getSubTitleStyle().copyWith(
                                    color: AppTheme.lightGrayTextColor,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      "الاحكام والشروط",
                      style: TextStyles(context).getSubTitleStyle().copyWith(
                            color: AppTheme.primaryColor,
                          ),
                      textAlign: TextAlign.right,
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 16),
                        child: Row(children: [
                          Expanded(
                              child: Divider(
                            color: AppTheme.lightGrayTextColor.withOpacity(0.5),
                            thickness: 1.6,
                          )),
                        ]))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
