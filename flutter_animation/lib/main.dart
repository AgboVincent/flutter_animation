import 'package:flutter/material.dart';
import 'package:flutter_animation/view/screens/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      designSize: const Size(414, 660),
      builder: (_, child){
        return  MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:   GoogleFonts.poppinsTextTheme(textTheme).copyWith(
              bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
              bodyLarge: GoogleFonts.poppins(textStyle: textTheme.bodyLarge),
              bodySmall: GoogleFonts.poppins(textStyle: textTheme.bodySmall),
            ),
            colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AnimatedPage(),
        );
      }
    );
  }
}
