import 'package:app/game_provider.dart';
import 'package:app/pages/user_detail_form_page.dart';
import 'package:app/data/theme.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String replicateKey = ""; // todo

main() {
  OpenAI.apiKey = ''; // todo
  OpenAI.requestsTimeOut = const Duration(seconds: 600);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        theme: theme,
        title: 'Echo',
        debugShowCheckedModeBanner: false,
        home: UserDetailFormPage(),
      ),
    );
  }
}