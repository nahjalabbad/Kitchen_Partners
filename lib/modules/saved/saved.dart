// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_constructors

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../constants/local_images_file.dart';
import '../../constants/themes.dart';
import '../../logic/providers/theme_provider.dart';
import '../../utils/text_style.dart';
import '../../widgets/bottom_to_top_animation_view.dart';
import '../../widgets/custom_appbar.dart';
import 'components/saved_container.dart';

class SavedScreen extends StatefulWidget {
  final AnimationController animationController;

  const SavedScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomToTopAnimationView(
      animationController: widget.animationController,
      child: Scaffold(
        body: SafeArea(
          child: Consumer<ThemeProvider>(
            builder: (_, provider, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomAppBarView(
                      centerWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' 😍 المفضلة ',
                              style: TextStyles(context)
                                  .getTitleStyle()
                                  .copyWith(
                                      color: AppTheme.primaryTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                            ),
                          ]),
                    ),
                  ),
                  SingleChildScrollView(
                    child: (Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SavedContainer(
                              image1: LocalImagesFile.fish_burger,
                              personName: 'رقية',
                              recipeName: 'برجر سمك',
                              serve: '1',
                              time: '20 دقيقة',
                            ),
                            SavedContainer(
                              image1: LocalImagesFile.blueberry_toast,
                              personName: 'زهراء',
                              recipeName: 'فرنش توست مع توت ازرق',
                              serve: '2',
                              time: '15 دقيقة ',
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
