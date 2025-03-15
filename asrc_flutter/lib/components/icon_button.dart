import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final bool usingPicture;
  final String? picturePath;

  const IconButtonWidget({
    super.key,
    required this.onTap,
    this.usingPicture = false,
    this.picturePath,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 50, 53, 62),
          borderRadius: BorderRadius.circular(50),
        ),
        child: usingPicture
            ? SvgPicture.asset(
                picturePath!,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                height: 20,
                width: 20,
              )
            : Icon(
                size: 20,
                icon,
                color: Colors.white,
              ),
      ),
    );
  }
}
