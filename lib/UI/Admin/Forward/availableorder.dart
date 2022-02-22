import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/Infrastructure/Agency/assigndriver.dart';

import '../../../constants.dart';

class availableOrders extends StatefulWidget {
  const availableOrders({Key? key, this.driver}) : super(key: key);
  final driver;

  @override
  _availableOrdersState createState() => _availableOrdersState();
}

class _availableOrdersState extends State<availableOrders> {
  late FirebaseAuth fauth;
  late FirebaseFirestore fstore;
  late assignfcade fcade;

  @override
  void initState() {
    fauth = FirebaseAuth.instance;
    fstore = FirebaseFirestore.instance;
    fcade = assignfcade(fauth: fauth, fstore: fstore);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Assign Order'),
            backgroundColor: Colors.green[700],
          ),
          body: FutureBuilder(
            future:
                fstore.collection('order').doc(fauth.currentUser!.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.get('orders') as List;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('Assign a Order'),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var cusOrder = data[index] as Map;
                          return cusOrder['status'] == 'processing' &&
                                  cusOrder['driver'] == ""
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: () async {
                                      return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Warning'),
                                            content: Text(
                                                'Are you sure want to forward the order?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.grey[400]),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await fcade.assignOrder(
                                                      index, widget.driver);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Ok'),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Card(
                                        child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          dummyProfilePictureUrl),
                                                      radius: 30,
                                                    ),
                                                    Text(cusOrder['cusname']),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text('Time: ' +
                                                            cusOrder['time']
                                                                .substring(0, 5)
                                                                .replaceAll(
                                                                    '-', ':')),
                                                        Text('Date: ' +
                                                            cusOrder['time']
                                                                .substring(
                                                                    6, 14)
                                                                .replaceAll(
                                                                    '-', '/')),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.grey[300],
                                                  thickness: 1,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      color: Colors.green,
                                                      size: 30,
                                                    ),
                                                    Text(
                                                        '${cusOrder['location']}')
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
                                                        Text(
                                                            cusOrder['amount']),
                                                        Text('Amount')
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(cusOrder[
                                                            'quantity']),
                                                        Text('Quantity')
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            cusOrder['status']),
                                                        Text('Status')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ))),
                                  ),
                                )
                              : Container();
                        },
                      )
                    ],
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('You have no order under processing.')],
                );
              }
              if (snapshot.hasData && !snapshot.data.exist) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('You have no order under processing.')],
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong.'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
