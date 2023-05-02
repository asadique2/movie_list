import 'package:flutter/material.dart';

import '../constant/colors.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  const CommonContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.disableBorderColor,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(2, 4), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
