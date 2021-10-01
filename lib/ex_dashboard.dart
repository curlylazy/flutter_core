import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  const DashboardPage({Key key}) : super(key: key);

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pushNamed('/');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "KONFIRMASI",
        style: TextStyle(fontSize: 12, letterSpacing: 2),
      ),
      content: Text("Log out dari sistem ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => {
        //       Navigator.pushNamed(
        //         context,
        //         '/',
        //       )
        //     },
        //   ),
        //   title: Text("Dashboard"),
        // ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BannerImageWidget(),
              SizedBox(height: 20),
              Container(
                  child: Wrap(children: [
                menuData(context, 'Data User',
                    'assets/images/014-customer service.png', '/user/list'),
                menuData(context, 'Data Item',
                    'assets/images/002-french fries.png', ''),
                menuData(context, 'Data Pelanggan',
                    'assets/images/009-courier.png', ''),
                btnLogout(context),
              ]))
            ],
          ),
        ),
      ),
    );
  }

  Widget menuData(
      BuildContext context, String judulmenu, String iconmenu, String url) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(url);
        },
        child: Container(
          width: 120,
          height: 140,
          child: Column(children: [
            Image.asset(
              iconmenu,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              judulmenu,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
          decoration: BoxDecoration(
              color: Colors.brown[100], borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
        ));
  }

  Widget btnLogout(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(
          //   context,
          //   '/login',
          // );
          // Navigator.of(context).pushNamed('/');
          showAlertDialog(context);
        },
        child: Container(
          width: 120,
          height: 140,
          child: Column(children: [
            Image.asset(
              'assets/images/logout.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              'Log Out',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
          decoration: BoxDecoration(
              color: Colors.brown[100], borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
        ));
  }
}

class BannerImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      alignment: Alignment.center,
      height: 200,
      child: Column(
        children: [
          Text('Aplikasi Resto',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                  color: Colors.white70,
                  fontSize: 35)),
          Text(
            'by inspirasi',
            style: TextStyle(color: Colors.white),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/dashboard.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(
          //   context,
          //   '/login',
          // );
          Navigator.of(context).pushNamed('/');
        },
        child: Container(
          width: 120,
          height: 140,
          child: Column(children: [
            Image.asset(
              'assets/images/logout.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              'Log Out',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
          decoration: BoxDecoration(
              color: Colors.brown[100], borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
        ));
  }
}

class TeksUtama extends StatelessWidget {
  final String judulmenu;
  final String iconmenu;

  TeksUtama({this.judulmenu, this.iconmenu});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
          print("Container clicked");
        },
        child: Container(
          width: 120,
          height: 140,
          child: Column(children: [
            Image.asset(
              iconmenu,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              judulmenu,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
          decoration: BoxDecoration(
              color: Colors.brown[100], borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
        ));
    // return Container(
    //   width: 120,
    //   height: 140,
    //   child: Column(children: [
    //     Image.asset(
    //       iconmenu,
    //       width: 50,
    //       height: 50,
    //       fit: BoxFit.cover,
    //     ),
    //     SizedBox(height: 10),
    //     Text(
    //       judulmenu,
    //       textAlign: TextAlign.center,
    //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    //     )
    //   ]),
    //   decoration: BoxDecoration(
    //       color: Colors.brown[100], borderRadius: BorderRadius.circular(5)),
    //   padding: const EdgeInsets.all(20),
    //   margin: const EdgeInsets.all(5),
    // );

    // https://api.flutter.dev/flutter/material/TextFormField-class.html
    // Wrap(
    //               children: List<Widget>.generate(5, (int index) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: ConstrainedBox(
    //                     constraints: BoxConstraints.tight(const Size(250, 50)),
    //                     child: TextFormField(
    //                       onSaved: (String? value) {
    //                         print('Value for field $index saved as "$value"');
    //                       },
    //                     ),
    //                   ),
    //                 );
  }
}
