import 'package:flutter/material.dart';
import 'login.dart';
import 'dashboard.dart';

// USER
import 'pages/user/user_ae.dart';
import 'pages/user/user_list.dart';

// PELANGGAN
import 'pages/pelanggan/pelanggan_ae.dart';
import 'pages/pelanggan/pelanggan_list.dart';

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
      initialRoute: '/pelanggan/list',
      routes: {
        '/': (context) => new LoginPage(),
        '/login': (context) => new LoginPage(),
        '/pelanggan/list': (context) => new PelangganList(),
        '/pelanggan/ae': (context) => new PelangganAE(),
        '/user/list': (context) => new UserList(),
        '/user/add': (context) => new UserAE(),
        '/dashboard': (context) => new DashboardPage(),
        '/nested': (context) => NestedApp(),
        '/dashboard2': (context) => Dashboard2(),
      },
    );
  }
}
