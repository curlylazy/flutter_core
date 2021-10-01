import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/dashboard.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('Resto App'),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ),
          body: Container(
            child: Column(
              children: [
                BannerImageWidget(),
                TeksUtama(
                  judulmenu: 'Master',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/dashboard.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TeksUtama extends StatelessWidget {
  final String judulmenu;

  TeksUtama({this.judulmenu});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 120,
      height: 100,
      child: Text(judulmenu, textAlign: TextAlign.center),
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(5),
    );
  }
}
