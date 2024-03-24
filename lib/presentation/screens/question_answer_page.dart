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
        return (questionAnswerProvider.isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: (questionAnswerProvider.questionModel!
                                    .questions[1].questionImageUrl !=
                                null)
                            ? 30.h
                            : 150.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 383.w,
                          decoration: BoxDecoration(
                            color: ColorConst.whiteColor,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: const Offset(0, 3), // Shadow position
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 5.w,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (questionAnswerProvider
                                                .questionModel!
                                                .questions[1]
                                                .questionImageUrl !=
                                            null)
                                        ? SizedBox(
                                            height: 200.h,
                                            child: Image.network(
                                              questionAnswerProvider
                                                  .questionModel!
                                                  .questions[1]
                                                  .questionImageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      questionAnswerProvider
                                          .questionModel!.questions[0].question,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        wordSpacing: 2,
                                      ),
                                    ),
                                  ],
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
                            String value = (index == 0)
                                ? 'A'
                                : (index == 1)
                                    ? "B"
                                    : (index == 2)
                                        ? "C"
                                        : "D";
                            return Padding(
                              padding: EdgeInsets.only(top: 15.h),
                              child: InkWell(
                                onTap: () {
                                  print(value);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConst.whiteColor,
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 5, // Spread radius
                                        blurRadius: 7, // Blur radius
                                        offset: const Offset(
                                            0, 3), // Shadow position
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
                                          "$value. ${questionAnswerProvider.questionModel!.questions[0].answers[value]}",
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
      }),
    );
  }
}
