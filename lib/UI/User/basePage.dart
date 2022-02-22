import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/UI/User/tankbook.dart';
import 'package:gps/UI/core/layouts/drawer.dart';
import 'package:gps/UI/google/g_map.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

class basePage extends StatefulWidget {
  const basePage({Key? key}) : super(key: key);

  @override
  State<basePage> createState() => _basePageState();
}

class _basePageState extends State<basePage> {
  late bool available;
  late FirebaseAuth fauth;
  late FirebaseFirestore fstore;

  @override
  void initState() {
    available = false;
    fauth = FirebaseAuth.instance;
    fstore = FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Water Tank'),
      ),
      drawer: profile(fauth: fauth),
      body: SafeArea(
        child: FutureBuilder(
          future:
              fstore.collection('booking').doc(fauth.currentUser!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data.exists) {
              var data = snapshot.data;
              if (data['status'] == "processing" && data['driver'] != "") {
                return FutureBuilder(
                  future:
                      fstore.collection('Driver').doc(data['driver']).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      var driver_data = snapshot.data;
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: data['driver'] != ""
                                      ? g_map(
                                          position: driver_data['position'],
                                          name: 'driver')
                                      : g_map()),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 240,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          spreadRadius: 5,
                                        )
                                      ],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Row(children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.yellow,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    'Driver accepted your request.'),
                                              ]),
                                              Text(
                                                'Arriving soon',
                                                style: TextStyle(
                                                    color: Colors.green[700]),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    '${driver_data['profile']}'),
                                                radius: 30,
                                              ),
                                              Text('${driver_data['name']}'),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            thickness: 1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text('Vehicle:'),
                                                  Text(
                                                      '${driver_data['vehicle']}')
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text('Vehicle No:'),
                                                  Text(
                                                      '${driver_data['regno']}')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            thickness: 1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text('Cancel'),
                                                style:
                                                    ElevatedButton.styleFrom(
                                                        primary: Colors.red),
                                              )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: ElevatedButton(
                                                onPressed: () async {
                                                  await launch(
                                                      'tel://${driver_data['phn']}');
                                                },
                                                child: Text('Call'),
                                                style:
                                                    ElevatedButton.styleFrom(
                                                        primary:
                                                            Colors.blueGrey),
                                              ))
                                            ],
                                          )
                                        ],
                                      ))),
                            )
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else if (data['status'] == 'processing') {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: g_map(),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 240,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text(
                                              data['agency'].substring(0, 1),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            radius: 30,
                                            backgroundColor: Colors.black12,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(data['agency']),
                                              Text('Delivery between 9AM-5PM')
                                            ],
                                          )
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            var phn_data = await fstore
                                                .collection('Agency')
                                                .doc(data['agencyuid'])
                                                .get();
                                            await launch(
                                                'tel://${phn_data.get('phn')}');
                                          },
                                          icon: Icon(
                                            Icons.phone,
                                            color: Colors.green[700],
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Order Processing',
                                          style: TextStyle(fontSize: 18))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        color: Colors.blue[50],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Amount Payable: ',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              '₹ ${data['amount']}',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: g_map(),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 240,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text(
                                              data['agency'].substring(0, 1),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            radius: 30,
                                            backgroundColor: Colors.black12,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(data['agency']),
                                              Text('Delivery between 9AM-5PM')
                                            ],
                                          )
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            var phn_data = await fstore
                                                .collection('Agency')
                                                .doc(data['agencyuid'])
                                                .get();
                                            await launch(
                                                'tel://${phn_data.get('phn')}');
                                          },
                                          icon: Icon(
                                            Icons.phone,
                                            color: Colors.green[700],
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Order Pending',
                                          style: TextStyle(fontSize: 18))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        color: Colors.blue[50],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Amount Payable: ',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              '₹ ${data['amount']}',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              }
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(dummyProfilePictureUrl)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Choose your Agency',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 155,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: fstore.collection('Agency').snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return Padding(
                            padding: EdgeInsets.all(50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: NetworkImage(
                                        'https://image.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg',
                                        scale: 3)),
                                Text(
                                  'Looks like you ran into some error.',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                    image: NetworkImage(
                                        'https://thumbs.dreamstime.com/b/upset-magnifying-glass-cute-not-found-symbol-unsuccessful-search-zoom-icon-no-suitable-results-upset-magnifying-glass-cute-122205498.jpg',
                                        scale: 3)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'NO Agency FOUND',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data.docs;
                          if(documents.isNotEmpty) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = documents[index];
                                    var avail = documents[index]['Availability']
                                    as List;
                                    return InkWell(
                                      onTap: () {},
                                      child: Card(
                                        elevation: 3.0,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(24),
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
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            '${data.get('name')}'),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            'Available water tank:'),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            '${avail[0]['quantity']} LTR'),
                                                        Text(
                                                            '${avail[1]['quantity']} LTR'),
                                                        Text(
                                                            '${avail[2]['quantity']} LTR'),
                                                      ],
                                                    ),
                                                  ]),
                                              Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        return showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                            context) {
                                                              return mybooking(
                                                                  agency: data);
                                                            });
                                                      },
                                                      color: Color(0xff4E295B),
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(20),
                                                      ),
                                                      child: Text(
                                                        'BOOK HERE',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ));
                          }
                          else {
                            return Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(Icons.assignment_late,size: 30,color: Colors.grey,),
                                  Text(
                                    'COMMING TO YOUR AREA SOON',
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Your location',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: g_map(),
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
