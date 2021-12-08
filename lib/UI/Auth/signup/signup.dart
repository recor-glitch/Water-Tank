import 'package:flutter/material.dart';
import 'package:gps/UI/Admin/tabs/admintabs.dart';

import 'Tabs/tab1.dart';
import 'Tabs/tab2.dart';
import 'Tabs/tab3.dart';

class signupPage extends StatefulWidget {

  @override
  State<signupPage> createState() => _loginPageState();
}

class _loginPageState extends State<signupPage> with TickerProviderStateMixin {

  late TextEditingController email, pass, name;
  final List<String> _tabs = <String>[
    "Agencies",
    "Customer",
    "Driver"
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.green[700],
              title: const Text('Water Tank'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Customer',
                    icon: Icon(Icons.person_add),
                  ),
                  Tab(
                    text: 'Agency',
                    icon: Icon(Icons.emoji_transportation),
                  ),
                  Tab(
                    text: 'Driver',
                    icon: Icon(Icons.assignment_ind_rounded),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            const tab2(),
            const tab1(),
            const tab3()
          ],
        ),

      ),
    );
  }
}
