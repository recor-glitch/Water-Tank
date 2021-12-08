import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps/Infrastructure/Authentication/reg_email_pass.dart';

class tab1 extends StatefulWidget {
  const tab1({Key? key}) : super(key: key);

  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {

  late TextEditingController email, pass, name;
  late final FirebaseAuth _fauth;
  late final FirebaseFirestore _fstore;
  late userfcade fcade;
  late bool isvisible, nameval, emailval, passval;
  late String res, nameres, emailres, passres;

  @override
  void initState() {
    email = new TextEditingController();
    pass = new TextEditingController();
    name = new TextEditingController();
    _fauth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    fcade = userfcade(_fauth, _fstore);
    isvisible = false;
    res = "";
    passres = "";
    passval = false;
    nameres = "";
    emailres = "";
    nameval = false;
    emailval = false;
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    name.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('Create Account',style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),
            Text('Enter your Email and Password for sign up.',style: TextStyle(color: Colors.black54),),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('Already have account?',style: TextStyle(color: Colors.green[600]),)),
            SizedBox(height: 30,),
            TextField(
              controller: name,
              onChanged: (s) {
                if(s.isNotEmpty) {
                  setState(() {
                    nameval = false;
                    passval = false;
                    emailval = false;
                    nameres = "";
                    emailres = "";
                    passres = "";
                  });
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  label: Text('Agency name'),
                  errorText: nameval? nameres : null,
                  floatingLabelBehavior: FloatingLabelBehavior.auto
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: email,
              onChanged: (s) {
                if(s.isNotEmpty) {
                  setState(() {
                    nameval = false;
                    passval = false;
                    emailval = false;
                    nameres = "";
                    emailres = "";
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
            SizedBox(height: 20,),
            TextField(
              controller: pass,
              onChanged: (s) {
                if(s.isNotEmpty) {
                  setState(() {
                    nameval = false;
                    passval = false;
                    emailval = false;
                    nameres = "";
                    emailres = "";
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
            const SizedBox(height: 30,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(onPressed: () async {
                setState(() {
                  isvisible = true;
                });
                if(name.text != "" && email.text != "" && pass.text != "") {
                  res = await fcade.CreateUser(name.text, email.text, pass.text, "agency");
                  if(res.contains('true')) {
                    isvisible = false;
                    Navigator.pushReplacementNamed(context, '/');
                  }
                  else {
                    setState(() {
                      isvisible = false;
                      if(res.contains('password')) {
                        passval = true;
                        passres = res;
                      }
                      if(res.contains('email')) {
                        emailval = true;
                        emailres = res;
                      }
                    });
                  }
                }
                else if(name.text == "") {
                  setState(() {
                    isvisible = false;
                    nameval = true;
                    nameres = "Enter agency name.";
                  });
                }
                else if(email.text == "") {
                  setState(() {
                    isvisible = false;
                    emailval = true;
                    emailres = "Enter your email.";
                  });
                }
                else if(pass.text == "") {
                  setState(() {
                    isvisible = false;
                    passval = true;
                    passres = "Enter your password.";
                  });
                }
              }, child: isvisible? Visibility(child: CircularProgressIndicator(color: Colors.white,),visible: isvisible,) : Text('SIGN UP AS AGENCY'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[600])
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(child: Text('By Signing up you agree to our Terms \n Conditions & Privacy Policy.',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),)),
            SizedBox(height: 20,),
            Center(child: Text('Or',style: TextStyle(color: Colors.black54,fontSize: 15))),
            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(onPressed: () {}, child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(EvaIcons.facebook),
                  SizedBox(width: 50,),
                  Text('CONNECT WITH FACEBOOK'),
                ],
              ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo[900])
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(onPressed: () {}, child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(EvaIcons.google),
                  SizedBox(width: 50,),
                  Text('CONNECT WITH GOOGLE'),
                ],
              ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
