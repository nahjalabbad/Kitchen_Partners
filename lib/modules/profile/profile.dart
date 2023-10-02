// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_partners/modules/home/components/morerecipe2.dart';
import '../../constants/local_images_file.dart';
import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/bottom_to_top_animation_view.dart';
import '../../widgets/common_button2.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  final AnimationController animationController;

  Profile({Key? key, required this.animationController}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    widget.animationController.forward();
    _quotesStream = FirebaseFirestore.instance
        .collection('Recipe')
        .where('uid', isEqualTo: user!.uid)
        .orderBy('createdOn', descending: false)
        .snapshots();
    super.initState();
  }

  Stream<QuerySnapshot>? _quotesStream;
  String name = "";
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) => setState(() {
              name = value.data()!['Name'];
            }));
    return Scaffold(
      body: BottomToTopAnimationView(
        animationController: widget.animationController,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [boxshadow],
                color: AppTheme.whiteTextColor,
                gradient: LinearGradient(
                    colors: [
                      Colors.grey.withOpacity(0.6),
                      Colors.grey.withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.9]),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                LocalImagesFile.profilebanner,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0, top: MediaQuery.of(context).padding.top),
              child: Row(
                children: [
                  Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      NavigationServices(context).gotoSettingsScreen(name);
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 20,
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 150 + MediaQuery.of(context).padding.top - 24,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 203, 194, 174),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              LocalImagesFile.user,
                              fit: BoxFit.cover,
                              scale: 1 / 7,
                            )),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              name,
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: CommonButton2(
                          radius: 12,
                          backgroundColor:
                              AppTheme.secondaryTextColor.withOpacity(0.08),
                          buttonText: "تحديث المعلومات",
                          textColor: AppTheme.lightGrayTextColor,
                          onTap: () {
                            NavigationServices(context).gotoAccountScreen();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: SingleChildScrollView(
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'وصفاتي',
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          //Text(
                          // '12 recipes',
                          // style: TextStyles(context).getDescriptionStyle().copyWith(
                          //      fontWeight: FontWeight.w300,
                          //   ),
                          //),
                        ],
                      ),
                    ),
                    ///////////////// call posting recipes/////////////////
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
                        return Column(
                          children: [
                            ListView.builder(
                                itemCount: chatdocs.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MoreRecipes2(
                                    isUser: true,
                                    data: chatdocs[index],
                                    isselected: false,
                                    imagepath: chatdocs[index]['image_url'],
                                    receipeName: chatdocs[index]['title'],
                                    serve: '0',
                                    time: chatdocs[index]['time_estimate'],
                                    category: chatdocs[index]['category'],
                                  );
                                }),
                          ],
                        );
                      },
                    ),
                    // ProfileRecipeContainer(
                    //   image1: LocalImagesFile.curry_salmon_soup,
                    //   uploaded: 'Uploaded 6 days ago',
                    //   recipeName: 'Curry Salmon Soup',
                    //   category: 'Soup',
                    //   time: '60 min',
                    //   serve: '',
                    // ),
                    // ProfileRecipeContainer(
                    //   image1: LocalImagesFile.beaf_romen,
                    //   uploaded: 'Uploaded 6 days ago',
                    //   category: 'Soup',
                    //   recipeName: 'Beef Ramen',
                    //   time: '35 min',
                    //   serve: '',
                    // ),
                    // ProfileRecipeContainer(
                    //   image1: LocalImagesFile.curry_salmon_soup,
                    //   uploaded: 'Uploaded 6 days ago',
                    //   recipeName: 'Curry Salmon Soup',
                    //   category: 'Soup',
                    //   time: '60 min',
                    //   serve: '',
                    // ),
                    // ProfileRecipeContainer(
                    //   image1: LocalImagesFile.beaf_romen,
                    //   uploaded: 'Uploaded 6 days ago',
                    //   category: 'Soup',
                    //   recipeName: 'Beef Ramen',
                    //   time: '35 min',
                    //   serve: '',
                    // ),
                    // ProfileRecipeContainer(
                    //   image1: LocalImagesFile.curry_salmon_soup,
                    //   uploaded: 'Uploaded 6 days ago',
                    //   recipeName: 'Curry Salmon Soup',
                    //   category: 'Soup',
                    //   time: '60 min',
                    //   serve: '',
                    // ),
                    // ProfileRecipeContainer(
                    //   image1: LocalImagesFile.beaf_romen,
                    //   uploaded: 'Uploaded 6 days ago',
                    //   category: 'Soup',
                    //   recipeName: 'Beef Ramen',
                    //   time: '35 min',
                    //   serve: '',
                    // ),

                    SizedBox(height: 100),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
