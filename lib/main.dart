import 'package:flutter/material.dart';
import 'login.dart';
import 'dashboard.dart';
import 'user_ae.dart';
import 'user_list.dart';
import 'ex_nested.dart';

//  ex
import 'ex_dashboard_2.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.brown,
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/user/list': (context) => UserList(),
        '/user/add': (context) => UserAE(),
        '/dashboard': (context) => DashboardPage(),
        '/nested': (context) => NestedApp(),
        '/dashboard2': (context) => Dashboard2(),
      },
    );
  }
}
