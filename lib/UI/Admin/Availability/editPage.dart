import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/Infrastructure/Agency/availabilityfcade.dart';



class editavailability extends StatefulWidget {
  const editavailability({Key? key,required this.option}) : super(key: key);
  final option;

  @override
  _editavailabilityState createState() => _editavailabilityState();
}

class _editavailabilityState extends State<editavailability> {

  late TextEditingController quantity;
  late TextEditingController price;
  late FirebaseAuth fauth;
  late FirebaseFirestore fstore;
  late availableFcade fcade;

  @override
  void initState() {
    quantity = TextEditingController();
    price = TextEditingController();

    fauth = FirebaseAuth.instance;
    fstore = FirebaseFirestore.instance;

    fcade = availableFcade(fauth, fstore);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    quantity.dispose();
    price.dispose();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit'),
      ),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Container(
              color: Colors.green[700],
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Align(
                    child: Icon(Icons.settings,size: 100,color: Colors.green),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(alignment: Alignment.bottomLeft,
                      child: Text(('Edit Details'),style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            buildTextField("Quantity", "Enter quantity",quantity),
            buildTextField("Price", "Enter price",price),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            child: Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if(quantity.text != "" && price.text != "") {
                                  await fcade.updateAvailability(int.parse(quantity.text), int.parse(price.text), widget.option);
                                  Navigator.pop(context);
                              }
                              else {
                                _showToast(context, 'Enter your quantity and price.');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            child: Text("Save",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                        )
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTextField(String labelText, String placeholder, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0, left: 20, right: 20),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.black,
          )),
    ),
  );
}


