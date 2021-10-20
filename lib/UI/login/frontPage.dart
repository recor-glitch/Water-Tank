import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class loginPage extends StatefulWidget {

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  late TextEditingController email, pass;

  @override
  void initState() {
    email = new TextEditingController();
    pass = new TextEditingController();
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Text('Welcome',style: TextStyle(fontSize: 30),),
                SizedBox(height: 20,),
                Text('Enter your Email address to sign in.',style: TextStyle(color: Colors.black54),),
                SizedBox(height: 10,),
                Text('Save water :)',style: TextStyle(color: Colors.black54),),
                SizedBox(height: 30,),
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
                ),
                SizedBox(height: 10,),
                TextButton(onPressed: () {}, child: Text('Forgot Password?',style: TextStyle(color: Colors.black54),)),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: () {}, child: Text('SIGN IN'),
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
                      Navigator.pushNamed(context, 'signup');
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
