import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/providers/question_answer_provider.dart';

import 'package:quiz_app/presentation/const/color_const.dart';
import 'package:quiz_app/presentation/const/image_const.dart';
import 'package:quiz_app/presentation/widgets/custom_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 60.r,
              child: Image.asset(ImageConst.appLogo),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your name",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                        )),
                  ),
                ],
              ),
            ),
            Consumer<QuestionAnswerProvider>(
                builder: (context, questionAnswerProvider, _) {
              return InkWell(
                onTap: () {
                  questionAnswerProvider.fetchQuestions();
                  Navigator.pushNamed(context, '/question_answer_screen');
                },
                child: CustomButtonWidget(
                  backgroundColor: ColorConst.startButtonColor,
                  name: "Start",
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
