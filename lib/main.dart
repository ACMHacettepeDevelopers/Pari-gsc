import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pari_gsc/views/base_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color.fromARGB(24, 63, 81, 181),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('PARI')),
        ),
        body: Center(
          child: BaseView(),
        ),
      ),
    );
  }
}
