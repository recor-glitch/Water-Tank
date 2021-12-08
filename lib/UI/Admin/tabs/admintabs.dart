import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class admintab1 extends StatefulWidget {
  const admintab1({Key? key}) : super(key: key);

  @override
  _admintab1State createState() => _admintab1State();
}

class _admintab1State extends State<admintab1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                      CircleAvatar(child: Icon(Icons.person,size: 30.0,),backgroundColor: Colors.black,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 430,
                padding: EdgeInsets.all(10.0),
                child: GridView.count(
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
                        onTap: (){},
                        splashColor: Colors.greenAccent,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.airport_shuttle_sharp, size: 70,),
                              Text('Truck & Driver Details', textAlign: TextAlign.center),
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
        )
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

  @override
  void initState() {
    _fstore = FirebaseFirestore.instance;
    _fauth = FirebaseAuth.instance;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
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
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListView.builder(itemBuilder: (BuildContext context, index) {
                      if(data![index].get('status') == 'pending') {
                        return Container();
                      }
                      return Container();
                    }),
                    ListView.builder(itemBuilder: (BuildContext context, index) {
                      if(data![index].get('status') == 'ongoing') {
                        return Container();
                      }
                      return Container();
                    }),
                    ListView.builder(itemBuilder: (BuildContext context, index) {
                      if(data![index].get('status') == 'done') {
                        return Container();
                      }
                      return Container();
                    }),

                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
      }),
    );
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

  @override
  void initState() {
    _fauth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: _fstore.collection('drivers').doc(_fauth.currentUser!.uid).get(),
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
                                  Navigator.pushNamed(context, '/add');
                                }, child: Text('Add a Driver'),style: ElevatedButton.styleFrom(
                                    primary: Colors.green[700]),
                                )
                            )
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}





