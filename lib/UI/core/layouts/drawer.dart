import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  final String name;
  final String email;
  final String profilepic;
  final FirebaseAuth fauth;

  profile({required this.name, required this.email, required this.profilepic, required this.fauth});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(profilepic),),
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
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              fauth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),

    );
  }
}