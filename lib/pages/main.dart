import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakery_project/services/controller.dart';
import 'package:bakery_project/services/itemService.dart';
import 'package:bakery_project/models/item.dart';

class MainPage extends StatefulWidget {
  // const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  void initState(){
    super.initState();
    // fetchItems();
    // print(flights);
  }


  @override
  Widget build(BuildContext context) {

    Controller ctrl = new Controller();
    print("Here");
    // fetchItems();
    final CollectionReference _items = FirebaseFirestore.instance.collection('items');

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body:
          Column(
            children: [
              Container(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, h * 0.01, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child:
                          ctrl.IsAdmin()?

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: w * 0.09,
                                  color: Colors.black,
                                ),
                              ]),
                              (ctrl.IsLoggedIn() == false) ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/login");
                                    },
                                    child: Icon(
                                      Icons.login,
                                      size: w * 0.09,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ):
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/login");
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
                                      Navigator.pushNamed(context, "/addItem");
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
                          ):
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: w * 0.09,
                                  color: Colors.black,
                                ),
                              ]),
                              (ctrl.IsLoggedIn() == false) ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                      Navigator.pushNamed(context, "/login");
                                    },
                                    child: Icon(
                                      Icons.login,
                                      size: w * 0.09,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ):
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/login");
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
        // ],
      // ),
      // bottomNavigationBar:
    );
  }
}
