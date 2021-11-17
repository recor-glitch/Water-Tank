import 'package:flutter/material.dart';

class profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Gourav'),
              accountEmail: Text('gauravmazumdar92@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Icon(Icons.account_circle)
                  ),
              ),
            decoration: BoxDecoration(
              color: Colors.green[700],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Details'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),

    );
  }
}