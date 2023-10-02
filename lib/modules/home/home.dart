// ignore_for_file: library_private_types_in_public_api, unnecessary_new, prefer_final_fields, prefer_const_constructors, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants/local_images_file.dart';
import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/bottom_to_top_animation_view.dart';
import '../../widgets/common_card.dart';
import '../../widgets/common_text_field_view.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/remove_focus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'components/morerecipe2.dart';

class HomeScreenView extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreenView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  String? name;
  TextEditingController searchCTRL = new TextEditingController();
  Stream<QuerySnapshot> _quotesStream = FirebaseFirestore.instance
      .collection('Recipe')
      .orderBy('createdOn', descending: false)
      .snapshots();
  final PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) => setState(() {
              name = value.data()!['Name'];
            }));
    return BottomToTopAnimationView(
      animationController: widget.animationController,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: RemoveFocuse(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  child: CustomAppBarView(
                    centerWidget: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                        ),
                        Text(
                          'ياهلا بك, ',
                          style: TextStyles(context).getTitle2Style().copyWith(
                              color: AppTheme.primaryTextColor,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.right,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                        ),
                        Text(
                          '$name!',
                          style: TextStyles(context).getTitle2Style().copyWith(
                              color: AppTheme.primaryTextColor,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.right,
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18, bottom: 8),
                  child: CommonCard(
                    radius: 15,
                    child: CommonTextFieldView(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.close),
                      hintText: 'البحث عن وصفات',
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          NavigationServices(context).gotoSearchScreen();
                        }
                      },
                      controller: searchCTRL,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 65),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              child: CarouselSlider(
                                items: [
                                  Image.asset(LocalImagesFile.Banner),
                                  Image.asset(LocalImagesFile.Collaboration2),
                                  Image.asset(LocalImagesFile.Collaboration3),
                                  Image.asset(LocalImagesFile.Collaboration4),
                                ],
                                options: CarouselOptions(
                                  height: 180,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 0.4,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 600),
                                  viewportFraction: 1,
                                ),
                              ),
                            ),
                            StreamBuilder(
                              stream: _quotesStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final chatdocs = snapshot.data!.docs;
                                print(chatdocs);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              NavigationServices(context)
                                                  .gotoUploadRecipeScreen();
                                            },
                                            child: Text(
                                              "المزيد",
                                              style: TextStyles(context)
                                                  .getDescriptionStyle(),
                                            ),
                                          ),
                                          Text(
                                            "جميع الوصفات",
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: chatdocs.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return MoreRecipes2(
                                            data: chatdocs[index],
                                            isselected: false,
                                            imagepath: chatdocs[index]
                                                ['image_url'],
                                            receipeName: chatdocs[index]
                                                ['title'],
                                            serve: '0',
                                            time: chatdocs[index]
                                                ['time_estimate'],
                                            category: chatdocs[index]
                                                ['category'],
                                          );
                                        }),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
