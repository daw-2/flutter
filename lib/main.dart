import 'package:flutter/material.dart';
import 'package:my_app/add_page.dart';
import 'package:my_app/home_page.dart';
import 'package:my_app/list_http.dart';
import 'package:my_app/list_page.dart';
import 'package:my_app/meal.dart';
import 'package:my_app/single_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiorella',
      onGenerateRoute: (settings) => Router.generate(settings),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)
      ),
      // home: const HomePage(),
      // ou bien
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/meals': (_) => const ListPage(),
        '/meal/new': (_) => const AddPage(),
        '/api': (_) => const ListHttp(),
      },
    );
  }
}

class Router {
  static Route<Object> generate(RouteSettings route) {
    return MaterialPageRoute(
      builder: (context) {
        if (route.name == '/') {
          return const HomePage();
        } else if (route.name == '/meals') {
          return const ListPage();
        } else if (route.name == '/meal') {
          return SinglePage(route.arguments as Meal);
        } else if (route.name == '/meal/new') {
          return const AddPage();
        } else if (route.name == '/api') {
          return const ListHttp();
        }

        return const HomePage();
      }
    );
  }
}
