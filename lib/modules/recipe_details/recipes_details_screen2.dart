// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../constants/local_images_file.dart';
import '../../constants/themes.dart';
import 'package:kitchen_partners/widgets/common_button2.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_button.dart';
import 'components/recipe_ingridents_container.dart';

class RecipeDetailsScreen2 extends StatefulWidget {
  var data;
  RecipeDetailsScreen2({Key? key, this.data}) : super(key: key);

  @override
  _RecipeDetailsScreen2State createState() => _RecipeDetailsScreen2State();
}

class _RecipeDetailsScreen2State extends State<RecipeDetailsScreen2> {
  bool onSave = false;
  @override
  Widget build(BuildContext context) {
    print(widget.data['ingridients']);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [boxshadow],
              color: AppTheme.whiteTextColor,
              gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.9),
                    Colors.grey.withOpacity(0.0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.7]),
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.data['image_url'],
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.0, top: 16 + MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: AppTheme.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                top: 210 + MediaQuery.of(context).padding.top - 24,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, bottom: 20, top: 16),
                        child: Text(
                          widget.data['title'],
                          style: TextStyles(context).getRegularStyle().copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.data['time_estimate'],
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.alarm,
                            size: 22,
                            color: AppTheme.lightGrayTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.data['description'],
                          textAlign: TextAlign.end,
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 500.0, left: 16),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 35, bottom: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: AppTheme.lightGrayTextColor.withOpacity(0.5),
                          thickness: 1.6,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                    child: Text(
                      'المقادير',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        itemCount: widget.data['ingridients'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 8),
                            child: RecipeIngridentsContainer(
                              name: widget.data['ingridients'][index],
                              quantity: '',
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: CommonButton2(
              radius: 12,
              buttonText: "العودة الى الصفحة الرئيسية",
              onTap: () {
                NavigationServices(context).gotoHomeScreen();
              },
            ),
          ),
        ],
      ),
    );
  }
}
