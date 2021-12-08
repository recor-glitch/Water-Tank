import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gps/Infrastructure/Agency/driver_details.dart';
import 'package:gps/Infrastructure/Authentication/reg_email_pass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;





class tab3 extends StatefulWidget {
  const tab3({Key? key}) : super(key: key);

  @override
  _adddriverState createState() => _adddriverState();
}

class _adddriverState extends State<tab3> {

  late TextEditingController name,phn,vehicle,reg,email,pass;
  late XFile _image;
  late ImagePicker picker;
  late FirebaseStorage _fstorage;
  late FirebaseFirestore _fstore;
  late FirebaseAuth _fauth;
  late bool imagevisible, nameval, phnval, vehicleval, regval, emailval, passval;
  late String imgUrl, nameres, phnres, vehicleres, regres, emailres, passres, result;
  late driverfcade d_fcade;
  late userfcade fcade;
  late bool visible;

  @override
  void dispose() {
    name.dispose();
    phn.dispose();
    vehicle.dispose();
    reg.dispose();
    email.dispose();
    pass.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void initState() {
    name = new TextEditingController();
    phn = new TextEditingController();
    vehicle = new TextEditingController();
    reg = new TextEditingController();
    email = new TextEditingController();
    pass = new TextEditingController();

    picker = ImagePicker();
    _fstorage = FirebaseStorage.instance;
    _fstore = FirebaseFirestore.instance;
    _fauth = FirebaseAuth.instance;
    imgUrl = "";
    result = "";
    visible = false;
    nameval = false;
    phnval = false;
    vehicleval = false;
    regval = false;
    emailval = false;
    passval = false;
    passres = "";
    emailres = "";
    nameres = "";
    phnres = "";
    vehicleres = "";
    regres = "";
    fcade = userfcade(_fauth, _fstore);
    // TODO: implement initState
    super.initState();
  }

  Future<void> get_Galleryimage() async {
    var picked = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = XFile(picked!.path);
      imgUrl = _image.path;
    });
  }

  Future<void> get_Cameraimage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = XFile(picked!.path);
      imgUrl = _image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Register as a driver',style: TextStyle(fontSize: 25),),
              SizedBox(height: 10,),
              const Text('Become a part of our family',style: TextStyle(color: Colors.green),),
              const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Stack(
                  children: [
                    Align(alignment: Alignment.center,child: imgUrl == ""? const CircleAvatar(child: Icon(Icons.person,size: 50.0,color: Colors.black45,),backgroundColor: Colors.black12,radius: 50,)
                        :  SizedBox(child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.file(i.File(_image.path),fit: BoxFit.cover,)),width: 100,height: 100,)
                    ),
                    Align(alignment: Alignment.centerRight,child: Column(children: [
                      InkWell(child: Icon(Icons.photo,size: 30,color: Colors.black45,),onTap: () {
                        get_Galleryimage();
                      },),
                      SizedBox(height: 20,),
                      InkWell(child: Icon(Icons.camera,size: 30,color: Colors.black45,),onTap: () {
                        get_Cameraimage();
                      },)
                    ],),)
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Driver Details',style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 20,),
                  TextField(
                    onChanged: (s) {
                      if(s.isNotEmpty) {
                        setState(() {
                          nameval = false;
                          phnval = false;
                          vehicleval = false;
                          regval = false;
                          nameres = "";
                          phnres = "";
                          vehicleres = "";
                          regres = "";
                          emailres = "";
                          emailval = false;
                          passval = false;
                          passres = "";
                        });
                      }
                    },
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        label: Text('Driver name'),
                        errorText: nameval? nameres : null,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    onChanged: (s) {
                      if(s.isNotEmpty) {
                        setState(() {
                          nameval = false;
                          phnval = false;
                          vehicleval = false;
                          regval = false;
                          nameres = "";
                          phnres = "";
                          vehicleres = "";
                          regres = "";
                          emailres = "";
                          emailval = false;
                          passval = false;
                          passres = "";
                        });
                      }
                    },
                    controller: phn,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        label: Text('+91'),
                        errorText: phnval? phnres : null,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: email,
                    onChanged: (s) {
                      if(s.isNotEmpty) {
                        setState(() {
                          nameval = false;
                          phnval = false;
                          vehicleval = false;
                          regval = false;
                          nameres = "";
                          phnres = "";
                          vehicleres = "";
                          regres = "";
                          emailres = "";
                          emailval = false;
                          passval = false;
                          passres = "";
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        label: Text('Email'),
                        errorText: emailval? emailres : null,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: pass,
                    onChanged: (s) {
                      if(s.isNotEmpty) {
                        setState(() {
                          nameval = false;
                          phnval = false;
                          vehicleval = false;
                          regval = false;
                          nameres = "";
                          phnres = "";
                          vehicleres = "";
                          regres = "";
                          emailres = "";
                          emailval = false;
                          passval = false;
                          passres = "";
                        });
                      }
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        label: Text('Password'),
                        errorText: passval? passres : null,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20,),
                  const Divider(thickness: 1,color: Colors.grey),
                  const SizedBox(height: 20,),
                  const Text('Vehicle Details',style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 20,),
                  TextField(
                    onChanged: (s) {
                      if(s.isNotEmpty) {
                        setState(() {
                          nameval = false;
                          phnval = false;
                          vehicleval = false;
                          regval = false;
                          nameres = "";
                          phnres = "";
                          vehicleres = "";
                          regres = "";
                          emailres = "";
                          emailval = false;
                          passval = false;
                          passres = "";
                        });
                      }
                    },
                    controller: vehicle,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        label: Text('Vehicle name'),
                        errorText: vehicleval? vehicleres : null,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    onChanged: (s) {
                      if(s.isNotEmpty) {
                        setState(() {
                          nameval = false;
                          phnval = false;
                          vehicleval = false;
                          regval = false;
                          nameres = "";
                          phnres = "";
                          vehicleres = "";
                          regres = "";
                          emailres = "";
                          emailval = false;
                          passval = false;
                          passres = "";
                        });
                      }
                    },
                    controller: reg,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        label: Text('Registration number'),
                        errorText: regval? regres : null,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(onPressed: () async {
                      setState(() {
                        visible = true;
                      });
                      if(name.text != "" && phn.text != "" && vehicle.text != "" && reg.text != "") {
                        result = await fcade.CreateUser(name.text, email.text, pass.text, 'driver');
                        d_fcade = driverfcade(_fauth,_fstore,_fstorage);
                        await d_fcade.Register_driver(name.text, phn.text, vehicle.text, reg.text, _image);
                        if(result.contains('true')) {
                          visible = false;
                          Navigator.pushReplacementNamed(context, '/');
                        }
                        else {
                          setState(() {
                            visible = false;
                            if(result.contains('password')) {
                              passval = true;
                              passres = result;
                            }
                            if(result.contains('email')) {
                              emailval = true;
                              emailres = result;
                            }
                          });
                        }
                      }
                      if(name.text == "") {
                        setState(() {
                          nameval = true;
                          nameres = "Enter your name";
                        });
                      }
                      if(phn.text == "") {
                        setState(() {
                          phnval = true;
                          phnres = "Enter your Phone number";
                        });
                      }
                      if(vehicle.text == "") {
                        setState(() {
                          vehicleval = true;
                          vehicleres = "Enter your vehicle name";
                        });
                      }
                      if(reg.text == "") {
                        setState(() {
                          regval = true;
                          regres = "Enter vehicle registration number";
                        });
                      }
                      if(email.text == "") {
                        setState(() {
                          emailres = "Enter your email";
                          emailval = true;
                        });
                      }
                      if(pass.text == "") {
                        setState(() {
                          passval = true;
                          passres = "Enter your password";
                        });
                      }
                    },child: visible? const CircularProgressIndicator()
                        : const Text('Submit'),style: ElevatedButton.styleFrom(primary: Colors.green[700]),),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}
