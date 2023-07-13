import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final dateofbirthController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final accounttypeController = DropdownEditingController<String>();

  final format = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    dateofbirthController.dispose();
    phoneController.dispose();
    nameController.dispose();
    accounttypeController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // add user details
      addUserDetails(
        accounttypeController.value.toString().trim(), 
        nameController.text.trim(),
        emailController.text.trim(),
        dateofbirthController.text.trim(), 
        int.parse(phoneController.text.trim())
        );

    }
  }

  Future addUserDetails(String accountType, String fullName, String email, 
  String dateofBirth, int phoneNumber) async {
    await FirebaseFirestore.instance.collection('users').add({

      'account type' : accountType,
      'full name' : fullName,
      'email' : email,
      'date of birth' : dateofBirth,
      'phone number' : phoneNumber,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 233, 241),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: SizedBox(
                    //   width: 360,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Center(
                        child: TextDropdownFormField(

                          controller: accounttypeController,
                          options: const [
                            "Personal Account",
                            "Government Account",
                            "Business Account",
                            "Basic Account",
                          ],

                          decoration: InputDecoration(

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(

                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 179, 154, 222)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: const OutlineInputBorder(),

                              suffixIcon: const Icon(Icons.arrow_drop_down,color: Color.fromARGB(255, 145, 136, 136),),
                              hintText: 'Account Type',
                              labelText: 'Account Type',
                              labelStyle:
                                  const TextStyle(color: Colors.deepPurple),
                              fillColor: Colors.grey[200],
                              filled: true),
                          dropdownHeight: 180,
                        ),
                      ),
                    ),
                    // ),
                  ),
                ),
                const SizedBox(height: 10),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    cursorColor: Colors.deepPurple,
                    controller: nameController,
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
                        hintText: 'Full Name',
                        labelText: 'Full Name',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    cursorColor: Colors.deepPurple,
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
                  child: DateTimeField(
                    controller: dateofbirthController,
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
                        hintText: 'Date of birth',
                        labelText: 'Date of birth',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = showDatePicker(
                        context: context,
                        initialDate: currentValue ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromARGB(255, 179, 154,
                                    222), // header background color
                                onPrimary:
                                    Colors.deepPurple, // header text color
                                onSurface: Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Colors.deepPurple, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      return date;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    cursorColor: Colors.deepPurple,
                    controller: phoneController,
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
                        hintText: 'Phone Number',
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    cursorColor: Colors.deepPurple,
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    cursorColor: Colors.deepPurple,
                    obscureText: true,
                    controller: confirmpasswordController,
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
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: signUp,
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
                          "Create account",
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("I have an account"),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        " Login now",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

