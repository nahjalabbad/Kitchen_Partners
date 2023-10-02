// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import '../../../constants/themes.dart';
import '../../../routes/route_names.dart';
import '../../../utils/text_style.dart';
import '../../../widgets/common_card.dart';

// ignore: must_be_immutable
class MoreRecipes extends StatefulWidget {
  final String receipeName;
  final String? serve;
  final String? time;
  final String? imagepath;
  bool isselected;

  MoreRecipes({
    required this.receipeName,
    this.serve,
    this.time,
    this.imagepath,
    this.isselected = false,
  });

  @override
  _MoreRecipesState createState() => _MoreRecipesState();
}

class _MoreRecipesState extends State<MoreRecipes> {
  VoidCallback? onsav;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 8, left: 16, right: 16),
      child: GestureDetector(
        onTap: () {
          NavigationServices(context).gotoRecipeDetailsScreen2;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CommonCard(
                  radius: 24,
                  child: ClipRRect(
                    child: Image.asset(widget.imagepath!,
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 16),
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.8),
                            Colors.grey.withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.7]),
                    ),
                    child: Center(
                      child: Text(
                        'باستا',
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteTextColor),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 14,
                  left: 4,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, bottom: 4),
                            child: Text(
                              widget.receipeName,
                              style: TextStyles(context)
                                  .getTitle2Style()
                                  .copyWith(
                                      color: AppTheme.whiteTextColor,
                                      fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 8, bottom: 4.0, top: 4),
                            child: Row(
                              children: [
                                Text(
                                  widget.time! + '  |  ',
                                  style: TextStyles(context)
                                      .getSubTitleStyle()
                                      .copyWith(
                                          color: AppTheme.whiteTextColor,
                                          fontSize: 16),
                                ),
                                Text(
                                  ' ' + widget.serve!,
                                  style: TextStyles(context)
                                      .getSubTitleStyle()
                                      .copyWith(
                                          color: AppTheme.whiteTextColor,
                                          fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey.withOpacity(0.7),
                                Colors.grey.withOpacity(0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.7]),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.isselected = !widget.isselected;
                              });
                            },
                            child: Icon(Icons.bookmark_outline,
                                color: widget.isselected
                                    ? AppTheme.primaryColor
                                    : AppTheme.whiteColor,
                                size: 23),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
