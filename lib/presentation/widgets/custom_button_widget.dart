import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.name,
    required this.backgroundColor,
  });
  final String name;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
