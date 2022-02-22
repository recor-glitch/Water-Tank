import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps/Infrastructure/User/booking.dart';
import 'package:gps/UI/core/widgets/estimatePriceCard.dart';
import 'package:gps/UI/google/g_map.dart';
import 'package:location/location.dart';



class mybooking extends StatefulWidget {
  final DocumentSnapshot agency;
  const mybooking({Key? key,required this.agency}) : super(key: key);

  @override
  _mybookingState createState() => _mybookingState();
}

class _mybookingState extends State<mybooking> {

  late userbooking book;
  late FirebaseFirestore fstore;
  late FirebaseAuth fauth;
  late int quantity, amt;
  late TextEditingController loc;
  late Location location;
  late bool visible;
  late LatLng pos;
  late List<dynamic> addresses;
  late int item1,item2,item3;
  late int price1, price2, price3;
  late String cusname;

  String dropdownvalue = 'COD';
  var items = ['COD', 'Online pay'];

  @override
  void initState() {
    item1 = 0;
    item2 = 0;
    item3 = 0;
    cusname = "";
    price1 = 200;
    price2 = 500;
    price3 = 1000;
    loc = TextEditingController();
    location = Location();
    pos = LatLng(26.144518, 91.736237);
    addresses = [];
    quantity = 0;
    amt = 0;
    visible = false;
    fauth = FirebaseAuth.instance;
    fstore = FirebaseFirestore.instance;
    book = userbooking(fauth: fauth, fstore: fstore);
    // TODO: implement initState
    super.initState();
  }

  Future<String> getName() async {
    var data = await fstore.collection('user').doc(fauth.currentUser!.uid).get();
    return data.get('name');
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
    return FutureBuilder(
      future: location.getLocation(),
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
        if(snapshot.hasData) {
          print('location found.');
          print('${snapshot.data!.latitude} ${snapshot.data!.longitude}');
          pos = LatLng(snapshot.data!.latitude as double, snapshot.data!.longitude as double);
        }
      return Scaffold(
        appBar: AppBar(
          title: Text('Water tank'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Stack(
                        children: [
                          g_map(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
                              child: Card(
                                child: TextField(
                                  controller: loc,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(16.0),
                                    hintText: "Enter your address",
                                    prefixIcon: Icon(Icons.location_on_outlined),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: fstore.collection('Agency').doc(widget.agency.get('uid')).get(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.hasData) {
                        var avail = snapshot.data.get('Availability') as List;

                        return Container(
                            padding: EdgeInsets.all(22.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text('Select your water requirement',style: TextStyle(fontSize: 20.0), ),
                                SizedBox(height: 10,),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.water,color: Colors.grey,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${avail[0]['quantity']} LTR'),
                                            Text('Fees: ${avail[0]['price']} Rupees')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            FloatingActionButton(
                                              child: Icon(EvaIcons.minus, color: Colors.black87),
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                if(item1 != 0) {
                                                  setState(() {
                                                    item1--;
                                                  });
                                                }
                                              },
                                            ),
                                            SizedBox(width: 10,),
                                            Text('$item1',style: TextStyle(fontSize: 18)),
                                            SizedBox(width: 10,),
                                            FloatingActionButton(
                                              child: Icon(Icons.add, color: Colors.black87),
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  item1++;
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.water,color: Colors.grey,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${avail[1]['quantity']} LTR'),
                                            Text('Fees: ${avail[1]['price']} Rupees')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            FloatingActionButton(
                                              child: Icon(EvaIcons.minus, color: Colors.black87),
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                if(item2 != 0) {
                                                  setState(() {
                                                    item2--;
                                                  });
                                                }
                                              },
                                            ),
                                            SizedBox(width: 10,),
                                            Text('$item2',style: TextStyle(fontSize: 18)),
                                            SizedBox(width: 10,),
                                            FloatingActionButton(
                                              child: Icon(Icons.add, color: Colors.black87),
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  item2++;
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.water,color: Colors.grey,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${avail[2]['quantity']} LTR'),
                                            Text('Fees: ${avail[2]['price']} Rupees')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            FloatingActionButton(
                                              child: Icon(EvaIcons.minus, color: Colors.black87),
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                if(item3 != 0) {
                                                  setState(() {
                                                    item3--;
                                                  });
                                                }
                                              },
                                            ),
                                            SizedBox(width: 10,),
                                            Text('$item3',style: TextStyle(fontSize: 18)),
                                            SizedBox(width: 10,),
                                            FloatingActionButton(
                                              child: Icon(Icons.add, color: Colors.black87),
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  item3++;
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                      return const Center(child: CircularProgressIndicator(),);
                  },),
                  Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      child:
                      item1 != 0 && item2 != 0 && item3 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                          item1 != 0 && item2 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                              item2 != 0 && item3 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                                  item1 != 0 && item3 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                                      item3 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                                          item2 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                                              item1 != 0? CustomCard(item1_price: price1, item1_quantity: item1, item2_price: price2, item2_quantity: item2, item3_price: price3, item3_quantity: item3, dilevery: 25) :
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image(image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/6404/6404715.png')),
                            ),
                            SizedBox(height: 20,),
                            Text('Please select your quantity.',
                              style: TextStyle(fontSize: 15),),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(onPressed: () async {
                  setState(() {
                    visible = true;
                  });
                  cusname = await getName();
                  if(item1 != 0 || item2 != 0 || item3 != 0){
                    if(loc.text != "") {

                      quantity = 500*item1 + 1000*item2 + 10000*item3;
                      amt = price1*item1 + price2*item2 + price3*item3;

                      await book.booking(name: cusname, latitude: pos.latitude, amt: amt.toString(), agencyUid: widget.agency.get('uid'), location: loc.text, agency: widget.agency.get('name'), longitude: pos.longitude, mode: dropdownvalue, quantity: quantity.toString()).whenComplete(() {
                        setState(() {
                          visible = false;
                        });
                        return _showToast(context, 'Your booking is successful.');
                      });
                      Navigator.pop(context);
                    }
                    else{
                      setState(() {
                        visible = false;
                      });
                      return _showToast(context, 'Please select your required address.');
                    }
                  }
                  else{
                    setState(() {
                      visible = false;
                    });
                    return _showToast(context, 'Please select your required quantity.');
                  }
                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.book_online),
                        SizedBox(width: 20,),
                        visible? CircularProgressIndicator() : Text('BOOK NOW'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButton(
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,style: TextStyle(color: Colors.white),),
                            );
                          }
                          ).toList(),
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                          dropdownColor: Colors.green,
                        )
                      ],
                    )
                  ],
                ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },);
  }
}

