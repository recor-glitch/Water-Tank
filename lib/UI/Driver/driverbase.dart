import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  
  @override
  void initState() {
    _fstore = FirebaseFirestore.instance;
    fauth = FirebaseAuth.instance;
    isSwitched = false;
    textValue = 'Go Online';
    location = Location();
    d_location = driverLocation(fauth: fauth, fstore: _fstore);
    // TODO: implement initState
    super.initState();
  }

  void toggleSwitch(bool value) async{
    if (isSwitched == false) {

      var position = await location.getLocation();
      d_location.setLocation(position.latitude as double, position.longitude as double);

      setState(() {
        isSwitched = true;
        textValue = 'You are Online';
      });
    }
    else {
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
        future: _fstore.collection('Driver').doc(fauth.currentUser!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError) {
          return const Center(child: Text('Something went wrong.'));
        }
        if(snapshot.hasData) {
          var data = snapshot.data;
          if(data.get('verification') == 'unverified') {
            return FutureBuilder(
              future: _fstore.collection('request').doc(fauth.currentUser!.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: NetworkImage('https://kb.accessally.com/wp-content/uploads/2018/07/warning.png')),
                      Text('Verification Pending',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Your account has not been verified yet. If you',style: TextStyle(fontSize: 15),),
                      Text('are having trouble in verification try signing in',style: TextStyle(fontSize: 15),),
                      Text('again.',style: TextStyle(fontSize: 15),),
                      SizedBox(height: 10,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(onPressed: () async {
                            await fauth.signOut();
                            Navigator.pushReplacementNamed(context, '/');
                          }, child: Text('Log out'),style: ElevatedButton.styleFrom(
                              primary: Colors.green[700]),
                          )
                      )
                    ],
                  );
                }
                if(snapshot.hasData) {
                  var data = snapshot.data;
                  if(data.data() == null || data.data() == {}) {
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: NetworkImage('https://kb.accessally.com/wp-content/uploads/2018/07/warning.png',scale: 2)),
                          Text('Verification Pending',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text('Your account has not been verified yet. If you',style: TextStyle(fontSize: 15),),
                          Text('are having trouble in verification try signing in',style: TextStyle(fontSize: 15),),
                          Text('again.',style: TextStyle(fontSize: 15),),
                          SizedBox(height: 10,),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(onPressed: () async {
                                await fauth.signOut();
                                Navigator.pushReplacementNamed(context, '/');
                              }, child: Text('Log out'),style: ElevatedButton.styleFrom(
                                  primary: Colors.green[700]),
                              )
                          )
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
                        SizedBox(height: 30,),
                        Text('You have request from:',style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: requests.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FutureBuilder(
                                  future: _fstore.collection('Agency').doc(requests[index]['uid']).get(),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if(snapshot.hasData) {
                                      return Card(
                                          child: Container(
                                            height: 230,
                                            width: MediaQuery.of(context).size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(child: Icon(Icons.emoji_transportation,size: 20,color: Colors.white,),radius: 20,backgroundColor: Colors.green[700],),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(snapshot.data.get('name'),style: TextStyle(fontSize: 20),)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(requests[index]['time'])
                                                    ],
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 30,right: 30),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text('Salary'),
                                                            Text('10000-12000')
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text('Monday-Sunday'),
                                                            Text('9AM-6PM')
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 2,),
                                                  Card(
                                                    elevation: 0,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.my_location,size: 30,color: Colors.green[700],),
                                                        SizedBox(width: 20,),
                                                        Text('Geetanagar, panipath')
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: ElevatedButton(onPressed: () {},
                                                            child: Text('Reject',style: TextStyle(color: Colors.black45),),
                                                            style: ElevatedButton.styleFrom(primary: Colors.grey[350]),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: ElevatedButton(onPressed: () async{
                                                            return showDialog(context: context, builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: Text('Warning'),
                                                                content: Text('Are you sure you want to work under ${snapshot.data.get('name')}?'),
                                                                actions: [
                                                                  ElevatedButton(onPressed: () {
                                                                    Navigator.pop(context);
                                                                  }, child: Text('Cancel')),
                                                                  ElevatedButton(onPressed: () async{
                                                                    await _fstore.collection('Driver').doc(fauth.currentUser!.uid).update(
                                                                      {
                                                                        'verification': snapshot.data.get('name')
                                                                      }
                                                                    );
                                                                    Navigator.pop(context);
                                                                  }, child: Text('Ok'))
                                                                ],
                                                              );
                                                            },);
                                                          },
                                                            child: Text('Accept'),
                                                            style: ElevatedButton.styleFrom(primary: Colors.green),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      );
                                    }
                                    return Card(child: Center(child: CircularProgressIndicator(),),);
                                  },);
                            },),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },);
          }
          if(data.get('verification') == 'rejected') {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: NetworkImage('https://assets.webiconspng.com/uploads/2016/12/Not-Verified-Icon-Image.png', scale: 2)),
                SizedBox(height: 20,),
                Text('SORRY!!!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('We reviewed your details and',style: TextStyle(fontSize: 15),),
                Text('you are not fit fot the post.',style: TextStyle(fontSize: 15),),
                Text('Good Luck!!',style: TextStyle(fontSize: 15),),
                SizedBox(height: 10,),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(onPressed: () async {
                      await fauth.signOut();
                      Navigator.pushNamed(context, '/');
                    }, child: Text('Log Out'),style: ElevatedButton.styleFrom(
                        primary: Colors.green[700]),
                    )
                )
              ],
            );
          }
          else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child:
                    Card(
                      color: Colors.white,
                      elevation: 5.0,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(textValue,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),),
                                      Text('Hi, ${snapshot.data.get('name')}', style: TextStyle(
                                          color: Colors.black, fontSize: 10),)
                                    ],
                                  ),
                                ]
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Switch(
                                        value: isSwitched, onChanged: toggleSwitch,
                                        activeTrackColor: Colors.lightGreenAccent,
                                        activeColor: Colors.green,
                                      )
                                    ],
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: g_map(),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child:
                      isSwitched ? Card(
                          child: Container(
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(child: Icon(
                                            Icons.emoji_transportation, size: 20,
                                            color: Colors.white,),
                                            radius: 20,
                                            backgroundColor: Colors.green[700],),
                                          SizedBox(width: 10,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Name",
                                                style: TextStyle(fontSize: 20),)
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text('27/12/21')
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Water Tank require'),
                                            Text('1000LTR')
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text('Delivery time'),
                                            Text('9AM-12PM')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(thickness: 2,),
                                  Card(
                                    elevation: 0,
                                    child: Row(
                                      children: [
                                        Icon(Icons.my_location, size: 30,
                                          color: Colors.green[700],),
                                        SizedBox(width: 20,),
                                        Text('Geetanagar, panipath')
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ElevatedButton(onPressed: () {},
                                              child: Text('Reject', style: TextStyle(
                                                  color: Colors.black45),),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey[350]),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text('Accept'),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ) :
                      Container(height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/6404/6404715.png',
                                scale: 4)),
                            SizedBox(height: 20,),
                            Text('Go online to find new orders',
                              style: TextStyle(fontSize: 15),),
                          ],
                        ),
                      )
                  ),
                  /*Container(height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: NetworkImage('https://cdn0.iconfinder.com/data/icons/basic-e-commerce-line-color/48/Shipping_cancel-256.png', scale: 2)),
                  SizedBox(height: 20,),
                  Text('You do not have any order yet.',style: TextStyle(fontSize: 15),),
                ],
              ),
            )*/
                ],
              ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },)
    );
  }
}
