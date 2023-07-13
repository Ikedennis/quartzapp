import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UsersPage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String dateofbirth;
  final String accounttype;
  final String roletype;
  final String id;
  const UsersPage(
      {this.name = '',
      this.phone = '',
      this.email = '',
      this.dateofbirth = '',
      this.accounttype = '',
      this.roletype = '',
      this.id = ''});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final user = FirebaseAuth.instance.currentUser!;
  void _signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
      // print(user);
      // setState(() {});
    } catch (e) {
     print(e);
     print('error signout');
    }
  
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 191, 169, 200),
          title: Text(
            user.email!,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  _signOut();
                // setState(() {});
                Navigator.of(context).pop();
                },
                child: const Icon(Icons.logout)),
            const Padding(
              padding: EdgeInsets.all(10),
            )
          ],
          centerTitle: true,
        ),
        body: Column(children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromARGB(255, 191, 169, 200),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                      Wrap(
                        spacing: 10.0,
                        children: [
                          const Icon(Icons.email_rounded),
                          Text(
                            widget.email,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          const Icon(Icons.person_4_rounded),
                          Text(
                            widget.roletype,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          Icon(Icons.phone),
                          Text(
                            widget.phone,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                    ],
                  );
                }
              })
        ]));
  }
}
