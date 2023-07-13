import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_pw_page.dart';


class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage; 
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future signIn() async {
    //loading circle
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),);
      },);
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    var myID = FirebaseAuth.instance.currentUser?.uid;
        print(myID);
        print('myID');
        
// final FirebaseAuth auth = FirebaseAuth.instance;
// final User? user = auth.currentUser;
//   final uid = user?.uid;
//   print(uid);
//   print('stopped');

  // final users = FirebaseFirestore.instance
  //                       .collection("users")
  //                       .doc(uid)
  //                       .get()
  //                       .then((value) => value)
  //                       .then((value) => value.data());
  //                       print(users);
  //                       Map<String, dynamic> data =
  //             users as Map<String, dynamic>;
  //         print(data);
                        
  // print('toppage');
//     User? user = FirebaseAuth.instance.currentUser;
//       print(user);
//       print('breaking');
// if (user!= null && !user.emailVerified) {
//   // await user.sendEmailVerification();
// }

    // pop the loading circle
    Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 238, 240),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "QUARTZ",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 50),
                Image.asset(
                  "assets/images/access.png",
                  height: 250,
                  width: 250,
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  
                      child: TextField(
                  controller: emailController,
                  
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 179, 154, 222)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.deepPurple),
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
                    ),
                  
                
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  
                      child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 179, 154, 222)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.deepPurple),
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
                    ),

                    const SizedBox(height: 10,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute
                              (builder: (context){
                                return const ForgotPasswordPage();
                              })
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.deepPurple),),
                          ),
                        ),
                      ],
                    ),
                  
                
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 191, 169, 200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 30),
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Don't have an account?"),
                //     GestureDetector(
                //       onTap: widget.showRegisterPage,
                //       child: const Text(
                //         " Signup here",
                //         style: TextStyle(
                //             color: Colors.deepPurple, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
