






import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../core/resources/strings.dart';

class BoxWithCounter extends StatelessWidget {
  final int? count;
  final double? size;
  final BoxShape shape;
  final Color? color;

  const BoxWithCounter({
    required this.count,
    required this.size, 
    required this.shape,
    required this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: shape == BoxShape.circle ? 
        null: BorderRadius.circular(30),
        shape: shape
      ),
      child: Column(
        children: [
          Gap(20.h),
           Text(
            shape == BoxShape.circle ? AppStrings.buy: AppStrings.rent,
            style: TextStyle(
              fontSize: 12.sp, 
              fontWeight: FontWeight.w600,
              color: shape == BoxShape.circle ? 
              Colors.white : const Color.fromARGB(255, 137, 122, 90),
            ),
          ),
          Gap(20.h),
          Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 30.sp, 
                fontWeight: FontWeight.w600,
                color: shape == BoxShape.circle ? 
                Colors.white : const Color.fromARGB(255, 137, 122, 90),
              ),
            ),
          ),
          Gap(4.h),
           Text(
            AppStrings.offers,
            style: TextStyle(
              fontSize: 12.sp, 
              fontWeight: FontWeight.w600,
              color: shape == BoxShape.circle ? 
              Colors.white : const Color.fromARGB(255, 137, 122, 90),
            ),
          ),
        ],
      ),
    );
  }
}
