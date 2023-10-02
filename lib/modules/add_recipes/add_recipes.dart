// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../constants/themes.dart';
import '../../routes/route_names.dart';
import '../../utils/text_style.dart';
import '../../widgets/bottom_to_top_animation_view.dart';

class AddRecipesScreen extends StatefulWidget {
  final AnimationController animationController;

  const AddRecipesScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  _AddRecipesScreenState createState() => _AddRecipesScreenState();
}

class _AddRecipesScreenState extends State<AddRecipesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    widget.animationController.forward();
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomToTopAnimationView(
      animationController: widget.animationController,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60, right: 4),
          child: FloatingActionButton(
            onPressed: () {
              NavigationServices(context).gotoUploadNewRecipesScreen();
            },
            child: Icon(
              Icons.add,
              color: AppTheme.whiteColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 24, bottom: 16),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "وصفاتي 👩‍🍳",
                    style: TextStyles(context).getTitleStyle(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: AppTheme.primaryColor,
                        labelColor: AppTheme.primaryTextColor,
                        unselectedLabelColor: AppTheme.lightGrayTextColor,
                        labelStyle: TextStyles(context).getTitleStyle(
                          fontsize: 16,
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          Tab(
                            text: 'مسودة',
                          ),
                          Tab(
                            text: 'وصفاتي',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "فطيرة فلافل",
                                      style: TextStyles(context)
                                          .getRegularStyle()
                                          .copyWith(fontSize: 18),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert))
                                  ],
                                ),
                                Text(
                                  "تم تعديلها قبل 12 دقيقة",
                                  style: TextStyles(context)
                                      .getDescriptionStyle()
                                      .copyWith(
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    height: 1,
                                    color: AppTheme.lightGrayTextColor,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "باستا حمراء",
                                          style: TextStyles(context)
                                              .getRegularStyle()
                                              .copyWith(fontSize: 18),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.more_vert))
                                      ],
                                    ),
                                    Text(
                                      "تم تعديلها من قبل يوم",
                                      style: TextStyles(context)
                                          .getDescriptionStyle()
                                          .copyWith(
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "كاري دجاج",
                                      style: TextStyles(context)
                                          .getRegularStyle()
                                          .copyWith(fontSize: 18),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    height: 1,
                                    color: AppTheme.lightGrayTextColor,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "فرنش توست بالتوت الازرق",
                                          style: TextStyles(context)
                                              .getRegularStyle()
                                              .copyWith(fontSize: 18),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.more_vert))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyRecipeContainer extends StatelessWidget {
  const MyRecipeContainer({
    Key? key,
    required this.detail,
    required this.count,
  }) : super(key: key);
  final String detail, count;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          detail,
          style: TextStyles(context).getDescriptionStyle().copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 4),
          child: Text(
            count,
            style: TextStyles(context)
                .getRegularStyle()
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
