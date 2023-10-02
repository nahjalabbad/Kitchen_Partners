// ignore_for_file: unnecessary_new, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kitchen_partners/services/firestore.dart';
import '../../constants/local_images_file.dart';
import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_card.dart';
import '../../widgets/common_text_field_view.dart';
import '../../widgets/custom_appbar.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

File? _image;

Future getImg(ImageSource source) async {
  final image = await ImagePicker().pickImage(source: source);
  _image = File(image!.path);

  final imgTemp = _image;
  print('Image picked');

  var headers = {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
    'Authorization': 'Bearer 85551a8b6cfd1bae49bef6732a9c6cc1075e99aa'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://api.logmeal.es/v2/image/recognition/complete/v1.0?&language=eng'));

  String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  request.files.add(http.MultipartFile.fromBytes(
      'image', File(imgTemp!.path).readAsBytesSync(),
      filename: imgTemp.path.split("/").last));

  print(getFileSizeString(bytes: imgTemp.lengthSync()));

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  //var response = await request.send();

  if (response.statusCode == 200) {
    var temp = await response.stream.bytesToString();
    // print(await response.stream.bytesToString());
    print('object');
    addIngredient(json.decode(temp)["recognition_results"][0]["name"],
        (json.decode(temp)["recognition_results"][0]["id"]).toString());
    // print(json.decode(temp)["recognition_results"][0]["name"]);
    print("successfully implemented");
  } else {
    print(response.reasonPhrase);
    print("Failure happen");
  }
}

// class recognition_results {
//   int? id;
//   String? name;

//   recognition_results({
//     this.id,
//     this.name,
//   });

//   recognition_results.fromJson(Map<String, dynamic> json) {
//     id = json['recognition_results']['id'];
//     name = json['recognition_results']['name'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> recognition_results = new Map<String, dynamic>();
//     recognition_results['id'] = this.id;
//     recognition_results['name'] = this.name;
//     return recognition_results;
//   }
// }

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchCTRL = new TextEditingController();

  Map<String, bool> filteration = {
    "إفطار": false,
    "غداء": false,
    "عشاء": false,
    "تحلية": false,
    "شوربة": false,
    "سلطة": false,
    "طبق رئيسي": false,
    "وجبة خفيفة": false,
  };

  Map<String, bool> cookingPeriod = {
    "١٥ دقيقة": false,
    "٣٠ دقيقة": false,
    "٦٠ دقيقة": false,
    "٩٠ دقيقة": false,
    "١٢٠ دقيقة": false,
  };

  Map<String, bool> ordering = {
    "الأحدث": false,
    "لأكثر شهرة": false,
    "الاعلى تصنيفا": false,
  };
  void _onBackPressed(val) {
    // print(val);
    // Navigator.pop(context);
  }
  String? category;
  String? time;
  String? ingridients;

  var temp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'البحث',
                  style: TextStyles(context).getTitle2Style().copyWith(
                      color: AppTheme.primaryTextColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
                  padding: EdgeInsets.only(
                      right: 16,
                      left: 16,
                      top: 8,
                      bottom: MediaQuery.of(context).padding.bottom + 8),
                  children: [
                CommonCard(
                  radius: 15,
                  child: CommonTextFieldView(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.close),
                    hintText: ' اكتب اسم الوصفة هنا',
                    controller: searchCTRL,
                    onChanged: (val) {
                      temp = val;
                      // if (val.length > 1) {
                      //   FocusManager.instance.primaryFocus?.unfocus();
                      // NavigationServices(context).gotoSearchResultScreen();
                      // }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons
                            .search_outlined), //icon data for elevated button
                        label: const Text(
                          "بحث",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          if (temp != null) {
                            NavigationServices(context).gotoSearchResultScreen(
                                temp, category, time, ingridients);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('الرجاء كتابة اسم وصفة للبحث'),
                            ));
                          }
                          // searchRecipe(
                          //     title: temp, onBackPressed: _onBackPressed);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.image), //icon data for elevated button
                        label: const Text(
                          "اضافة مكون باستخدام صورة",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          getImg(ImageSource.gallery);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.camera,
                      ),
                      label: Text(
                        "اضافة مكون بإستخدام الكاميرا",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        getImg(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "تصفية",
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  height: 350.0,
                  child: new ListView(
                    padding: EdgeInsets.only(
                        right: 16,
                        left: 16,
                        top: 8,
                        bottom: MediaQuery.of(context).padding.bottom + 8),
                    //scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    children: filteration.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: filteration[key],
                        onChanged: (value) {
                          setState(() {
                            category = key;
                            filteration[key] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "مدة التحضير",
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  height: 180.0,
                  child: new ListView(
                    padding: EdgeInsets.only(
                        right: 16,
                        left: 16,
                        top: 8,
                        bottom: MediaQuery.of(context).padding.bottom + 8),
                    //scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    children: cookingPeriod.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: cookingPeriod[key],
                        onChanged: (value) {
                          setState(() {
                            time = key;
                            cookingPeriod[key] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                // SizedBox(
                //   height: 25,
                // ),
                // Text(
                //   "الترتيب حسب",
                //   style: TextStyles(context)
                //       .getRegularStyle()
                //       .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.right,
                // ),
                // SizedBox(
                //   height: 180.0,
                //   child: new ListView(
                //     padding: EdgeInsets.only(
                //         right: 16,
                //         left: 16,
                //         top: 8,
                //         bottom: MediaQuery.of(context).padding.bottom + 8),
                //     //scrollDirection: Axis.vertical,
                //     //shrinkWrap: true,
                //     children: ordering.keys.map((String key) {
                //       return CheckboxListTile(
                //         title: Text(key),
                //         value: ordering[key],
                //         onChanged: (value) {
                //           setState(() {
                //             ordering[key] = value ?? false;
                //           });
                //         },
                //       );
                //     }).toList(),
                //   ),
                // ),
              ])),
        ],
      ),
    ));
  }
}
