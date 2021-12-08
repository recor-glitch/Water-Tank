import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/UI/core/layouts/drawer.dart';
import 'package:gps/UI/google/g_map.dart';
import '../../constants.dart';

class basePage extends StatefulWidget {
  const basePage({Key? key}) : super(key: key);

  @override
  State<basePage> createState() => _basePageState();
}

class _basePageState extends State<basePage> {

  late bool available;
  late FirebaseAuth fauth;

  @override
  void initState() {
    available = false;
    fauth = FirebaseAuth.instance;
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
      drawer: profile(name: 'Rishi',email: 'rishisarmah4@gmail.com',profilepic: dummyProfilePictureUrl,fauth: fauth,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 25,
                          backgroundImage: NetworkImage(dummyProfilePictureUrl)),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Around you',style: TextStyle(fontSize: 20,color: Colors.grey),)
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                    child: available? CarouselSlider(
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        pauseAutoPlayOnTouch: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        autoPlayInterval: Duration(seconds: 4),
                        enableInfiniteScroll: true,
                      ),
                      items: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image(image: NetworkImage(agencyIcon)),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text('Agency 1',style: TextStyle(fontSize: 20),),),
                                ],),
                            )
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image(image: NetworkImage(agencyIcon)),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text('Agency 2',style: TextStyle(fontSize: 20),),),
                                ],),
                            )
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image(image: NetworkImage(agencyIcon)),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text('Agency 3',style: TextStyle(fontSize: 20),),),
                                ],),
                            )
                        ),
                      ],
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_late_outlined,size: 50,color: Colors.grey),
                        SizedBox(height: 20,),
                        Text('Comming to your locality soon.',style: TextStyle(color: Colors.grey, fontSize: 25),),
                      ],
                    )
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Your location',style: TextStyle(fontSize: 20,color: Colors.grey),)
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: g_map(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
