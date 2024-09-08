import 'dart:io';

//import 'package:chatbot_app/constant/const.env';
import 'package:chatbot_app/constant/const.dart';
import 'package:chatbot_app/pages/chat_page.dart';
import 'package:chatbot_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


void main()async {
  Gemini.init(apiKey:API_KEY );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:HomePage()
    );
  }
}
