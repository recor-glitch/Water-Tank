import 'package:flutter/material.dart';

import 'Tabs/tab1.dart';
import 'Tabs/tab2.dart';

class signupPage extends StatefulWidget {

  @override
  State<signupPage> createState() => _loginPageState();
}

class _loginPageState extends State<signupPage> with TickerProviderStateMixin {

  late TextEditingController email, pass, name;
  final List<String> _tabs = <String>[
    "Agencies",
    "Customer"
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
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
                  )
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
          ],
        ),

      ),
    );
  }
}