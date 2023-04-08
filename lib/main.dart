import 'package:authenticate/model/user.dart';
import 'package:authenticate/screens/login_page.dart';
import 'package:authenticate/screens/splash_page.dart';
import 'package:authenticate/screens/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserState(),
        child: MaterialApp(
          title: 'Authenticate',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashPage(),
            '/login': (context) => const LoginPage(),
            '/user_detail': (context) => const UserDetailPage()
          },
        ));
  }
}
