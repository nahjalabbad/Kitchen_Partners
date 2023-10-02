// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import '../../constants/themes.dart';

class TabButtonUI extends StatelessWidget {
  final String tab;
  final Function()? onTap;
  final bool isSelected;

  const TabButtonUI({
    Key? key,
    this.onTap,
    required this.tab,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color =
        isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: tab != "assets/images/tab3.png"
              ? Image.asset(
                  tab,
                  height: 45,
                  color: _color,
                )
              : Image.asset(
                  tab,
                  height: 45,
                ),
        ),
      ),
    );
  }
}
