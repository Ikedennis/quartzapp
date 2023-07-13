
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_user_page.dart';
import 'package:flutter_application_1/pages/send_or_update_data_screen.dart';
import 'package:flutter_application_1/pages/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return  SendOrUpdateData();
          }));
        },
        backgroundColor: const Color.fromARGB(255, 191, 169, 200),
        icon: const Icon(Icons.add),
        label: const Text("Create New Account"),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "All Customers",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                // print(streamSnapshot.data!.docs[0]['user_role']);
                // print('streamSnapshot.data');
                

                return streamSnapshot.hasData
                    ? ListView.builder(
                        // padding: EdgeInsets.symmetric(vertical: 41),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          // print(streamSnapshot.data!.docs[index]['user_role']);
                          // print('streamSnapshot.data');
                          //  print(streamSnapshot.data!.docs[index].reference.id);
                          // print('streamSnapshot.id');
                          // print(streamSnapshot.data!.docs[index]['email']);
                          // print(user.email);
                          // print('check same');

                          return SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UsersPage(
                                            name: streamSnapshot
                                                .data!.docs[index]['full_name'],
                                            phone: streamSnapshot.data!
                                                .docs[index]['phone_number'],
                                            email: streamSnapshot
                                                .data!.docs[index]['email'],
                                            dateofbirth: streamSnapshot.data!
                                                .docs[index]['date_of_birth'],
                                            accounttype: streamSnapshot.data!
                                                .docs[index]['account_type'],
                                            roletype: streamSnapshot
                                                .data!.docs[index]['user_role'],
                                            id: streamSnapshot.data!.docs[index]
                                                ['id'],
                                          )));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 50,
                                        backgroundColor:
                                            Color.fromARGB(255, 191, 169, 200),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        streamSnapshot.data!.docs[index]
                                            ['full_name'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(
                                        streamSnapshot.data!.docs[index]
                                            ['email'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      trailing: Wrap(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditUserPage(
                                                            name: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['full_name'],
                                                            phone: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'phone_number'],
                                                            email: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['email'],
                                                            dateofbirth: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'date_of_birth'],
                                                            accounttype: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'account_type'],
                                                            roletype: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['user_role'],
                                                            id: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['id'],
                                                          )));
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.grey[600],
                                              size: 21,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final docData = FirebaseFirestore
                                                  .instance
                                                  .collection('users')
                                                  .doc(streamSnapshot
                                                      .data!.docs[index]['id']);
                                              await docData.delete();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.grey[600],
                                              size: 21,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        }))
                    : Center(
                        child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
