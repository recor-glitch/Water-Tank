import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps/constants.dart';

class admindrawer extends StatefulWidget {
  final FirebaseAuth fauth;

  admindrawer({required this.fauth});

  @override
  State<admindrawer> createState() => _admindrawerState();
}

class _admindrawerState extends State<admindrawer> {

  late FirebaseFirestore fstore;

  @override
  void initState() {
    fstore = FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder(
          future: fstore.collection('user').doc(widget.fauth.currentUser!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(snapshot.data.get('name')),
                    accountEmail: Text(snapshot.data.get('email')),
                    currentAccountPicture: const CircleAvatar(backgroundImage: NetworkImage(dummyProfilePictureUrl)),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile Details'),
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
                    title: Text('Availability'),
                    onTap: () => null,
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      widget.fauth.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },)

    );
  }
}