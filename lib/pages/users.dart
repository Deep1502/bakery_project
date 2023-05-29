import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bakery_project/services/controller.dart';


class Users extends StatefulWidget {
  // const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Controller ctrl = new Controller();
  double w = 0, h = 0;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'All Users',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: h*0.82,
              child: StreamBuilder(
                stream: _users.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                              margin: const EdgeInsets.all(10),
                              color: Color.fromRGBO(255, 248, 220,1),
                              child: ListTile(
                                  title: Text(documentSnapshot['username']),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          documentSnapshot['email'].toString()),
                                      Text(
                                        documentSnapshot['number'].toString()
                                      ),
                                    ],
                                  ),
                              )
                          );
                        });
                  } else {
                    return Text("Eror");
                  }
                },
              ),
            ),
            Container(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, h * 0.01, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: ctrl.IsAdmin()
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, "/users");
                                        },
                                        child: Icon(
                                          Icons.account_circle_rounded,
                                          size: w * 0.09,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  (ctrl.IsLoggedIn() == false)
                                      ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "/login");
                                              },
                                              child: Icon(
                                                Icons.login,
                                                size: w * 0.09,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "/login");
                                              },
                                              child: Icon(
                                                Icons.logout,
                                                size: w * 0.09,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/addItem");
                                        },
                                        child: Icon(
                                          Icons.add_box,
                                          size: w * 0.09,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, "/cart");
                                        },
                                        child: Icon(
                                          Icons.shopping_cart,
                                          size: w * 0.09,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  (ctrl.IsLoggedIn() == false)
                                      ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "/login");
                                              },
                                              child: Icon(
                                                Icons.login,
                                                size: w * 0.09,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "/login");
                                              },
                                              child: Icon(
                                                Icons.logout,
                                                size: w * 0.09,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
