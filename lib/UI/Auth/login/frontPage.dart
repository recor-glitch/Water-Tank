import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:gps/Infrastructure/Authentication/reg_email_pass.dart';

class loginPage extends StatefulWidget {

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  late TextEditingController email, pass;
  late FirebaseAuth _fauth;
  late FirebaseFirestore _fstore;
  late userfcade fcade;
  late String res, emailres, passres;
  late bool isvisible, emailval, passval;

  @override
  void initState() {
    email = new TextEditingController();
    pass = new TextEditingController();
    _fauth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    fcade = userfcade(_fauth,_fstore);
    res = "";
    isvisible = false;
    emailres = "";
    passres = "";
    emailval = false;
    passval = false;
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Water Tank'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('Welcome',style: TextStyle(fontSize: 30),),
                SizedBox(height: 20,),
                Text('Enter your Email address to sign in.',style: TextStyle(color: Colors.black54),),
                SizedBox(height: 10,),
                Text('Save water :)',style: TextStyle(color: Colors.black54),),
                SizedBox(height: 30,),
                TextField(
                  controller: email,
                  onChanged: (s) {
                    if(s.isNotEmpty) {
                      setState(() {
                        emailval = false;
                        emailres = "";
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
                SizedBox(height: 20,),
                TextField(
                  obscureText: true,
                  controller: pass,
                  onChanged: (s) {
                    if(s.isNotEmpty) {
                      setState(() {
                        emailval = false;
                        emailres = "";
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
                ),
                SizedBox(height: 10,),
                TextButton(onPressed: () {}, child: Text('Forgot Password?',style: TextStyle(color: Colors.black54),)),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: () async {
                    setState(() {
                      isvisible = true;
                    });
                    if(email.text != "" && pass.text != "") {
                      res = await fcade.SigninUser(email.text, pass.text);
                      if(res.contains('true')) {
                        setState(() {
                          isvisible = false;
                        });
                        Navigator.pushReplacementNamed(context, '/');
                      }
                      else {
                        setState(() {
                          isvisible = false;
                          if(res.contains('user')) {
                            emailval = true;
                            emailres = res;
                          }
                          if(res.contains('password')) {
                            passval = true;
                            passres = res;
                          }
                        });
                      }
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
                  }, child: isvisible? CircularProgressIndicator(color: Colors.white,) : Text('SIGN IN'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green[600])
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Dont have account?'),
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    }, child: Text('create new account.',style: TextStyle(color: Colors.green[600]),))
                  ],
                ),
                SizedBox(height: 20,),
                Center(child: Text('Or',style: TextStyle(color: Colors.black54,fontSize: 20))),
                SizedBox(height: 30,),
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
        ),
      ),
    );
  }
}
