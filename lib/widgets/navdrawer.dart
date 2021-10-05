import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
              height: 150,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ketoko Resto',
                      style: TextStyle(
                          color: Colors.white, fontSize: 22, letterSpacing: 3),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Solusi Manajemen Resto Online',
                      style: TextStyle(
                          color: Colors.white, fontSize: 13, letterSpacing: 1),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/sidebar.jpg')),
                ),
              )),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () => {Navigator.pushNamed(context, '/dashboard')},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('User'),
            onTap: () => {Navigator.pushNamed(context, '/user/list')},
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text('Pelanggan'),
            onTap: () => {Navigator.pushNamed(context, '/pelanggan/list')},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
