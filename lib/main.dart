import 'package:crypto_app/screens/home_page.dart';
import 'package:crypto_app/theme/colors.dart';
import 'package:crypto_app/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: MyColors.grey400),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: MyColors.white200,
          centerTitle: true,
          titleTextStyle:
              MyTextStyle.poppinsBold20.copyWith(color: MyColors.grey400),
        ),
      ),
      home: const HomePage(),
    );
  }
}
