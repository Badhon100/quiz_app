import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/providers/home_screen_provider.dart';
import 'package:quiz_app/data/providers/question_answer_provider.dart';
import 'package:quiz_app/routes/generated_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRoute _appRoute = AppRoute();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => QuestionAnswerProvider()),
                ChangeNotifierProvider(
                create: (context) => HomeScreenProvider()),
          ],
          child: MaterialApp(
            title: 'Quiz app',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              useMaterial3: true,
            ),
            onGenerateRoute: _appRoute.onGenerateRoute,
          ),
        );
      },
    );
  }
}
