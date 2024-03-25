import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/providers/question_answer_provider.dart';
import 'package:quiz_app/presentation/const/color_const.dart';
import 'package:quiz_app/presentation/widgets/custom_button_widget.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key});

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<QuestionAnswerProvider>(context, listen: false).startProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.backGroundColor,
      body: Consumer<QuestionAnswerProvider>(
          builder: (context, questionAnswerProvider, _) {
        return (questionAnswerProvider.isLoading)
            ? SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 300.h, horizontal: 100.w),
                  child: Column(
                    children: [
                      Text(
                        "Ready...",
                        style: TextStyle(
                          color: ColorConst.primaryColor,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      LinearProgressIndicator(
                        color: ColorConst.primaryColor,
                      ),
                    ],
                  ),
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: (questionAnswerProvider
                                    .questionModel!
                                    .questions[
                                        questionAnswerProvider.questionNo]
                                    .questionImageUrl !=
                                null)
                            ? 10.h
                            : 60.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${questionAnswerProvider.questionNo + 1}/${questionAnswerProvider.questionModel!.questions.length}",
                          style: TextStyle(
                            color: ColorConst.blackColor,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Current Score: ${questionAnswerProvider.totalScore}",
                          style: TextStyle(
                            color: ColorConst.primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        LinearProgressIndicator(
                          value: questionAnswerProvider.progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation(Colors.blue),
                        ),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Score: ${questionAnswerProvider.questionModel!.questions[questionAnswerProvider.questionNo].score}",
                                          style: TextStyle(
                                            color: ColorConst.primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    (questionAnswerProvider
                                                .questionModel!
                                                .questions[
                                                    questionAnswerProvider
                                                        .questionNo]
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
                                          .questionModel!
                                          .questions[
                                              questionAnswerProvider.questionNo]
                                          .question,
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
                        SizedBox(
                          height: 20.h,
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
                            return (questionAnswerProvider
                                        .questionModel!
                                        .questions[
                                            questionAnswerProvider.questionNo]
                                        .answers[value] ==
                                    null)
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: InkWell(
                                      onTap: () {
                                        print(value);
                                      },
                                      child: InkWell(
                                        onTap: (questionAnswerProvider
                                                .isTappedToAnswer)
                                            ? () {}
                                            : () {
                                                questionAnswerProvider
                                                    .pauseProgress();
                                                questionAnswerProvider
                                                    .tappedToAnswer(true);
                                                (questionAnswerProvider
                                                            .checkAnswer(
                                                                index) ==
                                                        questionAnswerProvider
                                                            .questionModel!
                                                            .questions[
                                                                questionAnswerProvider
                                                                    .questionNo]
                                                            .correctAnswer)
                                                    ? print("correct")
                                                    : print("not correct");
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: (questionAnswerProvider
                                                            .givenAnswerByUser !=
                                                        questionAnswerProvider
                                                            .questionModel!
                                                            .questions[
                                                                questionAnswerProvider
                                                                    .questionNo]
                                                            .correctAnswer &&
                                                    questionAnswerProvider
                                                            .givenAnswerIndex ==
                                                        index)
                                                ? ColorConst.startButtonColor
                                                : (questionAnswerProvider
                                                                .givenAnswerByUser ==
                                                            questionAnswerProvider
                                                                .questionModel!
                                                                .questions[
                                                                    questionAnswerProvider
                                                                        .questionNo]
                                                                .correctAnswer &&
                                                        questionAnswerProvider
                                                                .givenAnswerIndex ==
                                                            index)
                                                    ? ColorConst.greenColor
                                                    : ColorConst.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), // Shadow color
                                                spreadRadius:
                                                    5, // Spread radius
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
                                                  "$value. ${questionAnswerProvider.questionModel!.questions[questionAnswerProvider.questionNo].answers[value]}",
                                                  style: TextStyle(
                                                    color:
                                                        ColorConst.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                        (questionAnswerProvider
                                        .questionModel!.questions.length -
                                    1 >
                                questionAnswerProvider.questionNo)
                            ? CustomButtonWidget(
                                name: "Next",
                                backgroundColor: ColorConst.primaryColor,
                                onTap: () {
                                  questionAnswerProvider.userTotalScore(
                                    score: questionAnswerProvider
                                        .questionModel!
                                        .questions[
                                            questionAnswerProvider.questionNo]
                                        .score,
                                    answer: questionAnswerProvider
                                        .questionModel!
                                        .questions[
                                            questionAnswerProvider.questionNo]
                                        .correctAnswer,
                                  );
                                  questionAnswerProvider.resetAnswerInput();
                                  questionAnswerProvider.questionNoIncreament(
                                      questionAnswerProvider
                                          .questionModel!.questions.length);
                                  questionAnswerProvider.resetProgress();
                                  questionAnswerProvider.startProgress();
                                  questionAnswerProvider.tappedToAnswer(false);
                                })
                            : CustomButtonWidget(
                                name: "Complete",
                                backgroundColor: ColorConst.startButtonColor,
                                onTap: () {},
                              ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
