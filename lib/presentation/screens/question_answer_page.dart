import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/providers/question_answer_provider.dart';
import 'package:quiz_app/presentation/const/color_const.dart';
import 'package:quiz_app/presentation/widgets/custom_button_widget.dart';

class QuestionAnswerScreen extends StatelessWidget {
  const QuestionAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.backGroundColor,
      body: Consumer<QuestionAnswerProvider>(
          builder: (context, questionAnswerProvider, _) {
          return (questionAnswerProvider.isLoading)?
          const Center(
            child: CircularProgressIndicator(),
          )
          :SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 229.h,
                      width: 383.w,
                      decoration: BoxDecoration(
                        color: ColorConst.whiteColor,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: const Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: const Text(
                            "In what year did the United States host the FIFA World Cup for the first time?",
                            style: TextStyle(
                              color: Colors.black,
                              wordSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConst.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.grey.withOpacity(0.5), // Shadow color
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: const Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 6.w,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${index+1}. ",
                                    style: TextStyle(
                                      color: ColorConst.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButtonWidget(
                      name: "Next",
                      backgroundColor: ColorConst.primaryColor,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
