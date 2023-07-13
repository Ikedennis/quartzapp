// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/users_page.dart';

import 'admin_view_users.dart';
import 'home_page.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String myEmail = '';
  String myUsername = '';
  String myPhone = '';
  String userRole = 'User';
  @override
  void initState() {
    super.initState();
    _obj();
  }
  void _obj() async {
   User? user = FirebaseAuth.instance.currentUser;
   final QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
  .collection('users')
  .where('email', isEqualTo: user?.email)
  .get();
  //  FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
   print(user?.email);
   print('divider');
    
   setState(() {
    //  userRole = snap['user_role'];
    if (snap.docs.isNotEmpty) { 
DocumentSnapshot<Map<String, dynamic>> firstDoc = snap.docs[0];
userRole = firstDoc['user_role'];
myEmail = firstDoc['email'];
 myUsername = firstDoc['full_name'];
 myPhone = firstDoc['phone_number'];
 

  print(firstDoc['user_role']);
} else {
  print('No documents found.');
}
     });
     if (userRole == 'User') {
      redirectToNext(AUsersPage(name: myUsername, phone: myPhone, email: myEmail, roletype: userRole ));
     }
     else{
      redirectToNext(HomePage());
     }
  }
  void redirectToNext(Widget route){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> route));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "QUARTZ",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    letterSpacing: 2),
              ),
              SizedBox(height: 80),
              Text(
                "One app,",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    letterSpacing: 0),
              ),
              Text(
                "all things money",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    letterSpacing: 0),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/access.png",
                height: 300,
                width: 300,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
