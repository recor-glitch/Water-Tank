import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class availableDefault extends StatefulWidget {
  const availableDefault({Key? key}) : super(key: key);

  @override
  _availableDefaultState createState() => _availableDefaultState();
}

class _availableDefaultState extends State<availableDefault> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Availability'),
      ),
      body: SingleChildScrollView(
        child:
        Column(
            children: [
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(alignment: Alignment.center,
                          child: Text(('List of available water tank'),style: TextStyle(fontSize: 20, color: Colors.grey),),
                        ),
                      )
                    ],
                  )
              ),
              FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {

                }
                if(!snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      getCard(500, 200),
                      getCard(1000, 500),
                      getCard(10000, 1000)
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },)
            ]
        ),
      ),
    );
  }

  Widget getCard(int quantity, int price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
                        Text('Quantity: $quantity LTR'),
                      ],
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: $price Rupees'),
                      ],
                    ),
                  ]
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Color(0xff4E295B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Edit Details',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
