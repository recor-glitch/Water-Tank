import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/Infrastructure/Driver/request.dart';
import 'package:gps/Infrastructure/User/booking.dart';
import 'package:gps/UI/Admin/Availability/defaultPage.dart';
import 'package:gps/UI/core/layouts/profile.dart';
import 'package:gps/constants.dart';
import 'package:random_string/random_string.dart';

class admintab1 extends StatefulWidget {
  const admintab1({Key? key}) : super(key: key);

  @override
  _admintab1State createState() => _admintab1State();
}

class _admintab1State extends State<admintab1> {

  late FirebaseFirestore fstore;
  late FirebaseAuth fauth;

  @override
  void initState() {
    fstore = FirebaseFirestore.instance;
    fauth = FirebaseAuth.instance;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: fstore.collection('user').doc(fauth.currentUser!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${snapshot.data.get('name')}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                          CircleAvatar(backgroundImage: NetworkImage(dummyProfilePictureUrl),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: [
                          Card(
                            color: Colors.green,
                            margin: EdgeInsets.all(8.0),
                            elevation: 8,
                            child: InkWell(
                              onTap: (){},
                              splashColor: Colors.greenAccent,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.app_registration, size: 70,),
                                    Text('Order Management'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.green,
                            margin: EdgeInsets.all(8.0),
                            elevation: 8,
                            child: InkWell(
                              onTap: (){},
                              splashColor: Colors.greenAccent,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.workspaces_outline, size: 70,),
                                    Text('Employee management', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.green,
                            margin: EdgeInsets.all(8.0),
                            elevation: 8,
                            child: InkWell(
                              onTap: (){},
                              splashColor: Colors.greenAccent,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.analytics_outlined, size: 70,),
                                    Text('Profit and loss'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.green,
                            margin: EdgeInsets.all(8.0),
                            elevation: 8,
                            child: InkWell(
                              onTap: () async{
                                return showDialog(context: context, builder: (BuildContext context) {
                                  return availableDefault();
                                });
                              },
                              splashColor: Colors.greenAccent,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.airport_shuttle_sharp, size: 70,),
                                    Text('Manage Availability', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Earnings',style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                            TextButton(onPressed: () {}, child: Text('View details'))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Personal balance',style: TextStyle(color: Colors.black,fontSize: 15.0),),
                                      Text('\$0',style: TextStyle(color: Colors.green,fontSize: 20.0,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Avg. selling price',style: TextStyle(color: Colors.black,fontSize: 15.0),),
                                      Text('\$0',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Pending clearance',style: TextStyle(color: Colors.black,fontSize: 15.0),),
                                      Text('\$0',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Earning',style: TextStyle(color: Colors.black,fontSize: 15.0),),
                                      Text('\$0',style: TextStyle(color: Colors.black,fontSize: 20.0),)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Active orders',style: TextStyle(color: Colors.black,fontSize: 15.0),),
                                      Text('0',style: TextStyle(color: Colors.black,fontSize: 20.0),)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Cancelled orders',style: TextStyle(color: Colors.black,fontSize: 15.0),),
                                      Text('0',style: TextStyle(color: Colors.black,fontSize: 20.0),)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('To;Dos',style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('0 unread messages\n Your response time is good.keep up the\n great work!',style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text('0'),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },)
    );
  }
}

class admintab2 extends StatefulWidget {
  const admintab2({Key? key}) : super(key: key);

  @override
  _admintab2State createState() => _admintab2State();
}

class _admintab2State extends State<admintab2> {

  late FirebaseFirestore _fstore;
  late FirebaseAuth _fauth;
  late int r,g,b;
  late List pending_list, processing_list, done_list;
  late userbooking book;

  @override
  void initState() {
    _fstore = FirebaseFirestore.instance;
    _fauth = FirebaseAuth.instance;
    r = 0;
    g = 0;
    b = 0;
    book = userbooking(fauth: _fauth, fstore: _fstore);
    pending_list = [];
    processing_list = [];
    done_list = [];
    // TODO: implement initState
    super.initState();
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      processing_list.clear();
      pending_list.clear();
      done_list.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fstore.collection('order').doc(_fauth.currentUser!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: NetworkImage('https://image.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg',scale: 3)),
                  Text('Looks like you ran into some error.',style: TextStyle(fontSize: 20),)
                ],
              ),
            );
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: NetworkImage('https://thumbs.dreamstime.com/b/upset-magnifying-glass-cute-not-found-symbol-unsuccessful-search-zoom-icon-no-suitable-results-upset-magnifying-glass-cute-122205498.jpg',scale: 3)),
                  SizedBox(height: 20,),
                  Text('NO ORDER FOUND',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('Looks like you haven received',style: TextStyle(fontSize: 15),),
                  Text('any order yet.',style: TextStyle(fontSize: 15),),
                  SizedBox(height: 10,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(onPressed: () {}, child: Text('Back to Menu'),style: ElevatedButton.styleFrom(
                          primary: Colors.green[700]
                      ),))
                ],
              ),
            );
          }
          if(snapshot.hasData && snapshot.data!.exists) {
            var data = snapshot.data;
            var _list = data!.get('orders') as List<dynamic>;
            _list.forEach((element) {
              if(element['status'] == 'pending') {
                pending_list.add(element);
              }
              if(element['status'] == 'processing') {
                processing_list.add(element);
              }
              if(element['status'] == 'done') {
                done_list.add(element);
              }
            });
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        pending_list.isNotEmpty?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('New Orders',style: TextStyle(fontSize: 20),),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: pending_list.length,
                                itemBuilder: (BuildContext context, index) {
                                  int r = randomBetween(0, 256);
                                  int g = randomBetween(0, 256);
                                  int b = randomBetween(0, 256);
                                  var cusOrder = pending_list[index] as Map;
                                  return Card(
                                      color: Color.fromRGBO(r, g, b, 1),
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CircleAvatar(backgroundImage: NetworkImage(dummyProfilePictureUrl),radius: 30,),
                                                  Text(cusOrder['cusname']),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text('Time: '+ cusOrder['time'].substring(0,5).replaceAll('-',':')),
                                                      Text('Date: '+ cusOrder['time'].substring(6,14).replaceAll('-','/')),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Divider(color: Colors.grey[300],thickness: 1,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.location_pin,color: Colors.green,size: 30,),
                                                  Text('${cusOrder['location']}')
                                                ],
                                              ),
                                              Divider(color: Colors.grey[300],thickness: 1,),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['amount']),
                                                      Text('Amount')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['quantity']),
                                                      Text('Quantity')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['status']),
                                                      Text('Status')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: ElevatedButton(onPressed: () {  }, child: Text('Cancel'),style: ElevatedButton.styleFrom(primary: Colors.grey[400]),)),
                                                  SizedBox(width: 20,),
                                                  Expanded(child: ElevatedButton(onPressed: () async {
                                                    return showDialog(context: context, builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Warning'),
                                                        content: Text('Are you sure?\n You want to accept these order?'),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              Expanded(child: ElevatedButton(onPressed: () { Navigator.pop(context); }, child: Text('Cancel'),style: ElevatedButton.styleFrom(primary: Colors.grey[400]),)),
                                                              Expanded(child: ElevatedButton(onPressed: () async {
                                                                await book.acceptOrder(index);
                                                                Navigator.pop(context);
                                                              }, child: Text('Accept'),style: ElevatedButton.styleFrom(primary: Colors.green),)),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    },);
                                                  }, child: Text('Accept'),style: ElevatedButton.styleFrom(primary: Colors.green),)),
                                                  SizedBox(width: 20,),
                                                  IconButton(icon: Icon(Icons.share,size: 20,color: Colors.white,), onPressed: () {  },)
                                                ],
                                              )
                                            ],
                                          )
                                      )
                                  );
                                })
                          ],
                        ) :
                        Container(),
                        processing_list.isNotEmpty?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Active Orders',style: TextStyle(fontSize: 20),),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: processing_list.length,
                                itemBuilder: (BuildContext context, index) {
                                  int r = randomBetween(0, 256);
                                  int g = randomBetween(0, 256);
                                  int b = randomBetween(0, 256);
                                  var cusOrder = processing_list[index] as Map;
                                  return Card(
                                      color: Color.fromRGBO(r, g, b, 1),
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CircleAvatar(backgroundImage: NetworkImage(dummyProfilePictureUrl),radius: 30,),
                                                  Text(cusOrder['cusname']),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text('Time: '+ cusOrder['time'].substring(0,5).replaceAll('-',':')),
                                                      Text('Date: '+ cusOrder['time'].substring(6,14).replaceAll('-','/')),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Divider(color: Colors.grey[300],thickness: 1,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.location_pin,color: Colors.green,size: 30,),
                                                  Text('${cusOrder['location']}')
                                                ],
                                              ),
                                              Divider(color: Colors.grey[300],thickness: 1,),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['amount']),
                                                      Text('Amount')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['quantity']),
                                                      Text('Quantity')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['status']),
                                                      Text('Status')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                            ],
                                          )
                                      )
                                  );
                                })
                          ],
                        ) :
                        Container(),
                        done_list.isNotEmpty?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your History',style: TextStyle(fontSize: 20),),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: done_list.length,
                                itemBuilder: (BuildContext context, index) {
                                  int r = randomBetween(0, 256);
                                  int g = randomBetween(0, 256);
                                  int b = randomBetween(0, 256);
                                  var cusOrder = done_list[index] as Map;
                                  return Card(
                                      color: Color.fromRGBO(r, g, b, 1),
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CircleAvatar(backgroundImage: NetworkImage(dummyProfilePictureUrl),radius: 30,),
                                                  Text(cusOrder['cusname']),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text('Time: '+ cusOrder['time'].substring(0,5).replaceAll('-',':')),
                                                      Text('Date: '+ cusOrder['time'].substring(6,14).replaceAll('-','/')),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Divider(color: Colors.grey[300],thickness: 1,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.location_pin,color: Colors.green,size: 30,),
                                                  Text('${cusOrder['location']}')
                                                ],
                                              ),
                                              Divider(color: Colors.grey[300],thickness: 1,),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['amount']),
                                                      Text('Amount')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['quantity']),
                                                      Text('Quantity')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(cusOrder['status']),
                                                      Text('Status')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.star,color: Colors.yellow,),
                                                  Icon(Icons.star,color: Colors.yellow,),
                                                  Icon(Icons.star,color: Colors.yellow,),
                                                  Icon(Icons.star,color: Colors.yellow,),
                                                  Icon(Icons.star_border,color: Colors.yellow,),
                                                ],
                                              )
                                            ],
                                          )
                                      )
                                  );
                                })
                          ],
                        ) :
                        Container()
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
    });
  }
}

class admintab3 extends StatefulWidget {
  const admintab3({Key? key}) : super(key: key);

  @override
  _admintab3State createState() => _admintab3State();
}

class _admintab3State extends State<admintab3> {

  late FirebaseAuth _fauth;
  late FirebaseFirestore _fstore;
  late bool search;
  late requestfcade fcade;
  late String response, agecy_name;
  late List drivers;

  @override
  void initState() {
    agecy_name = "";
    drivers = [];
    _fauth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    search = false;
    fcade = requestfcade(fauth: _fauth,fstore: _fstore);
    response = "";
    super.initState();
  }

  @override
  void dispose() {
    drivers.clear();
    search = false;
    // TODO: implement dispose
    super.dispose();
  }

  void _showToast(BuildContext context,String txt) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(txt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: search? StreamBuilder(
              stream: _fstore.collection('Driver').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: NetworkImage('https://image.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg',scale: 3)),
                        Text('Looks like you ran into some error.',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  );
                }
                if(!snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(image: NetworkImage('https://thumbs.dreamstime.com/b/upset-magnifying-glass-cute-not-found-symbol-unsuccessful-search-zoom-icon-no-suitable-results-upset-magnifying-glass-cute-122205498.jpg',scale: 3)),
                        SizedBox(height: 20,),
                        Text('NO DRIVERS FOUND',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                }
                if(snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Available Drivers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                        ListView(
                          shrinkWrap: true,
                            children: documents
                                .map((doc) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                              child: ListTile(
                                  leading: CircleAvatar(radius: 30,backgroundImage: NetworkImage('${doc['profile']}')),
                                  title: Text('${doc['name']}'),
                                  subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text('${doc['phn']}'),Text('${doc['vehicle']}'),Text('${doc['regno']}')]),
                                  trailing: TextButton(onPressed: () async {
                                    return showDialog(context: context, builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Warning',style: TextStyle(color: Colors.black,fontSize: 20),),
                                        content: Text('Are you sure want to recruit the driver for your business?\n you will not be able to revert the change.'),
                                        actions: [
                                          ElevatedButton(onPressed: () {
                                            Navigator.pop(context);
                                          }, child: Text('Cancel')),
                                          ElevatedButton(onPressed: () async {
                                            response = await fcade.initiateRequest(doc['uid']);
                                            if(response != "") {
                                              _showToast(context, response);
                                              Navigator.pop(context);
                                            }
                                          }, child: Text('Recruit')),
                                        ],
                                      );
                                    });
                                  },
                                  child: Text('Recruit',style: TextStyle(color: Colors.green[700]),),),
                                  onTap: () async {
                                    return showDialog(context: context, builder: (BuildContext context) {
                                      return profiledetails(fauth: _fauth,uid: doc['uid'],);
                                    });
                                  },
                                  dense: false,
                              ),
                            ),
                                ))
                                .toList()),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              },) :
            FutureBuilder(
              future: _fstore.collection('user').doc(_fauth.currentUser!.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> fsnapshot) {
                if(fsnapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: NetworkImage('https://image.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg',scale: 3)),
                        Text('Looks like you ran into some error.',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  );
                }
                if(fsnapshot.hasData) {
                  agecy_name = fsnapshot.data.get('name');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: _fstore.collection('Driver').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.hasError) {
                          return Padding(
                            padding: EdgeInsets.all(50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: NetworkImage('https://image.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg',scale: 3)),
                                Text('Looks like you ran into some error.',style: TextStyle(fontSize: 20),)
                              ],
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: NetworkImage('https://image.freepik.com/free-vector/man-searching-car-rent_74855-7610.jpg',scale: 3)),
                                SizedBox(height: 20,),
                                Text('NO DRIVERS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text('Looks like you have no registered drivers',style: TextStyle(fontSize: 15),),
                                Text('Add a driver to complete orders.',style: TextStyle(fontSize: 15),),
                                SizedBox(height: 10,),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(onPressed: () {
                                      setState(() {
                                        search = true;
                                      });
                                    }, child: Text('Search Driver'),style: ElevatedButton.styleFrom(
                                        primary: Colors.green[700]),
                                    )
                                )
                              ],
                            ),
                          );
                        }
                        if(snapshot.hasData) {
                          List<DocumentSnapshot> documents = snapshot.data.docs;

                          if(agecy_name != "") {
                            for (var element in documents) {
                              if(element.get('verification') == agecy_name) {
                                drivers.add(element);
                              }
                            }
                          }
                          if(drivers.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text('Driver working under you'),
                                  ListView.builder(
                                    itemBuilder: (BuildContext context, int index) {
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(backgroundImage: NetworkImage(drivers[index]['profile']),radius: 30),
                                                  Column(
                                                    children: [
                                                      Text(drivers[index]['name']),
                                                      Text(drivers[index]['phn'])
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(onPressed: () {}, icon: Icon(Icons.phone,color: Colors.blue[600],)),
                                                      IconButton(onPressed: () {}, icon: Icon(Icons.forward_5,color: Colors.green,)),
                                                    ],
                                                  )
                                                ],
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: drivers.length,
                                    shrinkWrap: true,
                                  )
                                ],
                              ),
                            );
                          }
                          else {
                            return Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(image: NetworkImage('https://image.freepik.com/free-vector/man-searching-car-rent_74855-7610.jpg',scale: 3)),
                                  SizedBox(height: 20,),
                                  Text('NO DRIVERS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Text('Looks like you have no registered drivers',style: TextStyle(fontSize: 15),),
                                  Text('Add a driver to complete orders.',style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(onPressed: () {
                                        setState(() {
                                          search = true;
                                        });
                                      }, child: Text('Search Driver'),style: ElevatedButton.styleFrom(
                                          primary: Colors.green[700]),
                                      )
                                  )
                                ],
                              ),
                            );
                          }
                          //Show the driver working under these agency...
                        }
                        return Center(child: CircularProgressIndicator(),);
                      })
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}





