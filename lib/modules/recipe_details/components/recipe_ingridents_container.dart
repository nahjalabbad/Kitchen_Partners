import 'package:flutter/material.dart';

import '../../../constants/themes.dart';
import '../../../utils/text_style.dart';

class RecipeIngridentsContainer extends StatelessWidget {
  const RecipeIngridentsContainer({
    Key? key,
    required this.name,
    required this.quantity,
  }) : super(key: key);
  final String name, quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.lightGrayTextColor.withOpacity(0.08),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style:
                  TextStyles(context).getRegularStyle().copyWith(fontSize: 18),
            ),
            Text(
              quantity,
              style: TextStyles(context).getDescriptionStyle().copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
