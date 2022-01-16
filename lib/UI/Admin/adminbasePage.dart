import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/UI/Admin/tabs/admintabs.dart';
import 'package:gps/UI/core/layouts/drawer.dart';



class adminbasePage extends StatefulWidget {
  const adminbasePage({Key? key}) : super(key: key);

  @override
  _adminbasePageState createState() => _adminbasePageState();
}

class _adminbasePageState extends State<adminbasePage> with TickerProviderStateMixin {

  late TabController _tabController;
  late FirebaseAuth fauth;

  @override
  void initState() {
    fauth = FirebaseAuth.instance;
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: profile(fauth: fauth),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: [
                IconButton(onPressed: () {
                  fauth.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                }, icon: Icon(Icons.exit_to_app))
              ],
              backgroundColor: Colors.green[700],
              title: Text('Water Tank'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Home',
                    icon: Icon(Icons.home_filled),
                  ),
                  Tab(
                    text: 'Orders',
                    icon: Icon(Icons.list),
                  ),
                  Tab(
                    text: 'Drivers',
                    icon: Icon(EvaIcons.car),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            admintab1(),
            admintab2(),
            admintab3()
          ],
        ),

      ),
    );
  }
}
