import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class signupPage extends StatefulWidget {

  @override
  State<signupPage> createState() => _loginPageState();
}

class _loginPageState extends State<signupPage> {

  late TextEditingController email, pass, name;

  @override
  void initState() {
    email = new TextEditingController();
    pass = new TextEditingController();
    name = new TextEditingController();
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,
                child: Stack(
                  children: [
                    InkWell(child: Icon(Icons.arrow_back_ios),onTap: () {
                      Navigator.pop(context);
                    },),
                    Align(
                      alignment: Alignment.center,
                        child: Text('Create Account',style: TextStyle(fontSize: 25)))
                  ],
                ),
                ),
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      label: Text('Name'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      label: Text('Email'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: pass,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      label: Text('Password'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10,),
                TextButton(onPressed: () {}, child: Text('Forgot Password?',style: TextStyle(color: Colors.black54),)),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: () {}, child: Text('SIGN UP'),
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
        ),
      ),
    );
  }
}
