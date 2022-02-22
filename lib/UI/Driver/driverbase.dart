import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gps/Infrastructure/Driver/driver_location.dart';
import 'package:gps/UI/core/layouts/drawer.dart';
import 'package:gps/UI/google/g_map.dart';
import 'package:location/location.dart';

class driverbase extends StatefulWidget {
  const driverbase({Key? key}) : super(key: key);

  @override
  _driverbaseState createState() => _driverbaseState();
}

class _driverbaseState extends State<driverbase> {
  late FirebaseFirestore _fstore;
  late FirebaseAuth fauth;
  late bool isSwitched;
  late String textValue;
  late Location location;
  late driverLocation d_location;
  late bool isavail;
  var cus_pos;

  @override
  void initState() {
    isavail = false;
    _fstore = FirebaseFirestore.instance;
    fauth = FirebaseAuth.instance;
    isSwitched = false;
    textValue = 'Go Online';
    location = Location();
    d_location = driverLocation(fauth: fauth, fstore: _fstore);
    // TODO: implement initState
    super.initState();
  }

  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      var position = await location.getLocation();
      d_location.setLocation(
          position.latitude as double, position.longitude as double);

      setState(() {
        isSwitched = true;
        textValue = 'You are Online';
      });
    } else {
      d_location.offineStatus();

      setState(() {
        isSwitched = false;
        textValue = 'Go Online';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text('Water Tank'),
        ),
        drawer: profile(fauth: fauth),
        body: FutureBuilder(
          future:
              _fstore.collection('Driver').doc(fauth.currentUser!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong.'));
            }
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (data.get('verification') == 'unverified') {
                return FutureBuilder(
                  future: _fstore
                      .collection('request')
                      .doc(fauth.currentUser!.uid)
                      .get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: NetworkImage(
                                  'https://kb.accessally.com/wp-content/uploads/2018/07/warning.png')),
                          Text(
                            'Verification Pending',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Your account has not been verified yet. If you',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'are having trouble in verification try signing in',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'again.',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await fauth.signOut();
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: Text('Log out'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green[700]),
                              ))
                        ],
                      );
                    }
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      if (data.data() == null || data.data() == {}) {
                        return Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image: NetworkImage(
                                      'https://kb.accessally.com/wp-content/uploads/2018/07/warning.png',
                                      scale: 2)),
                              Text(
                                'Verification Pending',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Your account has not been verified yet. If you',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'are having trouble in verification try signing in',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'again.',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await fauth.signOut();
                                      Navigator.pushReplacementNamed(
                                          context, '/');
                                    },
                                    child: Text('Log out'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green[700]),
                                  ))
                            ],
                          ),
                        );
                      }
                      var requests = data.get('request') as List<dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'You have request from:',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: requests.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FutureBuilder(
                                      future: _fstore
                                          .collection('Agency')
                                          .doc(requests[index]['uid'])
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData) {
                                          return Card(
                                              child: Container(
                                            height: 230,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                              Icons
                                                                  .emoji_transportation,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            radius: 20,
                                                            backgroundColor:
                                                                Colors
                                                                    .green[700],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snapshot.data
                                                                    .get(
                                                                        'name'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(requests[index]
                                                              ['time']
                                                          .substring(0, 8))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text('Salary'),
                                                            Text('10000-12000')
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                                'Monday-Sunday'),
                                                            Text('9AM-6PM')
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2,
                                                  ),
                                                  Card(
                                                    elevation: 0,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.my_location,
                                                          size: 30,
                                                          color:
                                                              Colors.green[700],
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(snapshot.data
                                                            .get('address'))
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Reject',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black45),
                                                            ),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Colors
                                                                            .grey[
                                                                        350]),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              return showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Warning'),
                                                                    content: Text(
                                                                        'Are you sure you want to work under ${snapshot.data.get('name')}?'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('Cancel')),
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await _fstore.collection('Driver').doc(fauth.currentUser!.uid).update({
                                                                              'verification': snapshot.data.get('name')
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('Ok'))
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child:
                                                                Text('Accept'),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                        }
                                        return Card(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              }
              if (data.get('verification') == 'rejected') {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        image: NetworkImage(
                            'https://assets.webiconspng.com/uploads/2016/12/Not-Verified-Icon-Image.png',
                            scale: 2)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'SORRY!!!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'We reviewed your details and',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'you are not fit fot the post.',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Good Luck!!',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            await fauth.signOut();
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text('Log Out'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[700]),
                        ))
                  ],
                );
              } else {
                return SafeArea(
                  child: Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height,
                          child: isavail
                              ? g_map(
                                  position: cus_pos,
                                  name: 'user',
                                )
                              : g_map()),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color: Colors.white,
                              elevation: 5.0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                textValue,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                'Hi, ${snapshot.data.get('name')}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Switch(
                                                value: isSwitched,
                                                onChanged: toggleSwitch,
                                                activeTrackColor:
                                                    Colors.lightGreenAccent,
                                                activeColor: Colors.green,
                                              )
                                            ],
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: 230,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 3.0,
                                    blurRadius: 5.0,
                                    color: Colors.black12)
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30)),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: isSwitched
                                ? StreamBuilder(
                                    stream: _fstore
                                        .collection('booking')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        var data = snapshot.data.docs as List;
                                        if (data.isNotEmpty) {
                                          return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return data[index]['driver'] ==
                                                      fauth.currentUser!.uid
                                                  ? Card(
                                                      child: Container(
                                                      height: 230,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .emoji_transportation,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      radius:
                                                                          20,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green[700],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          data[index]
                                                                              [
                                                                              'cusname'],
                                                                          style:
                                                                              TextStyle(fontSize: 20),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(data[index]
                                                                        ['time']
                                                                    .substring(
                                                                        6, 14)
                                                                    .replaceAll(
                                                                        '-',
                                                                        '/'))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 30,
                                                                      right:
                                                                          30),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                          'Water Tank require'),
                                                                      Text(data[
                                                                              index]
                                                                          [
                                                                          'quantity'])
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                          'Delivery time'),
                                                                      Text(
                                                                          '9AM-12PM')
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Divider(
                                                              thickness: 2,
                                                            ),
                                                            Card(
                                                              elevation: 0,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .my_location,
                                                                    size: 30,
                                                                    color: Colors
                                                                            .green[
                                                                        700],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(data[
                                                                          index]
                                                                      [
                                                                      'location'])
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          return showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: Text('Warning'),
                                                                                content: Text('Are you sure want to cancel the order?'),
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text('Cancel'),
                                                                                    style: ElevatedButton.styleFrom(primary: Colors.grey[400]),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      await d_location.cancelOrder(index, data[index]['uid'], data[index]['agencyuid']);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text('Ok'),
                                                                                    style: ElevatedButton.styleFrom(primary: Colors.green),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Reject',
                                                                          style:
                                                                              TextStyle(color: Colors.black45),
                                                                        ),
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                Colors.grey[350]),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          return showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: Text('Warning'),
                                                                                content: Text('Have you completed the order?'),
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text('Cancel'),
                                                                                    style: ElevatedButton.styleFrom(primary: Colors.grey[400]),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      await d_location.completeOrder(index, data[index]['uid'], data[index]['agencyuid']);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text('Ok'),
                                                                                    style: ElevatedButton.styleFrom(primary: Colors.green),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child: Text(
                                                                            'Complete'),
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                Colors.green),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              'assets/searching.png'),
                                                          fit: BoxFit.contain,
                                                          height: 160,
                                                          width: 200,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          'Searching for any order assigned to you.',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child:
                                                              LinearProgressIndicator(),
                                                        )
                                                      ],
                                                    );
                                            },
                                          );
                                        } else {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/searching.png'),
                                                fit: BoxFit.contain,
                                                height: 160,
                                                width: 200,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Searching for any order assigned to you.',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child:
                                                    LinearProgressIndicator(),
                                              )
                                            ],
                                          );
                                        }
                                      }
                                      if (!snapshot.hasData) {
                                        return Container(
                                          height: 150,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                  image: NetworkImage(
                                                      'https://cdn0.iconfinder.com/data/icons/basic-e-commerce-line-color/48/Shipping_cancel-256.png',
                                                      scale: 2)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'You do not have any order yet.',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  )
                                : Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                            image: NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/512/6404/6404715.png',
                                                scale: 4)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Go online to find new orders',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )),
                      ),
                    ],
                  ),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
