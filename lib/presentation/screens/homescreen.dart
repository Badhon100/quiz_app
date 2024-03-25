import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/providers/home_screen_provider.dart';
import 'package:quiz_app/data/providers/question_answer_provider.dart';

import 'package:quiz_app/presentation/const/color_const.dart';
import 'package:quiz_app/presentation/const/image_const.dart';
import 'package:quiz_app/presentation/widgets/custom_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeScreenProvider>(context, listen: false).getScores();
  }
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
              child: Consumer<HomeScreenProvider>(
                  builder: (context, homeScreenProvider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top score: ${homeScreenProvider.highScore}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Score: ${homeScreenProvider.score}",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
            Consumer<QuestionAnswerProvider>(
                builder: (context, questionAnswerProvider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButtonWidget(
                  backgroundColor: ColorConst.startButtonColor,
                  name: "Start",
                  onTap: (){
                          questionAnswerProvider.fetchQuestions();
                          Navigator.pushNamed(context, '/question_answer_screen');
                        },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
