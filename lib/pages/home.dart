import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bakery_project/services/controller.dart';
import 'package:bakery_project/models/item.dart';

import '../services/itemService.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Controller ctrl = new Controller();
  double h = 0, w = 0;
  List<Item> userCart = [];
  Stream<List<Item>> readItems() => FirebaseFirestore.instance
      .collection('items')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  Widget buildItem(Item item) => Card(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(255, 248, 220,1),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: IntrinsicHeight(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.network(item.url, height: h * 0.15, width: w * 0.30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      item.name,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      item.flavour,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      item.price.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                        (!ctrl.IsAdmin())?
                          TextButton(onPressed: (){
                            userCart.add(item);
                            userCart.forEach((item) {
                              print(item.name + " " + item.flavour + " " + item.price.toString());
                            });
                          }, child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                            ),
                          )):Text(''),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Items',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: h * 0.82,
              child: StreamBuilder<List<Item>>(
                  stream: readItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error occured!!!");
                    } else if (snapshot.hasData) {
                      final Items = snapshot.data;
                      return ListView(
                        children: Items!.map(buildItem).toList(),
                      );
                    } else {
                      return Text("Loading...");
                    }
                  }),
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
                                          Navigator.pushNamed(
                                              context, "/users");
                                        },
                                        child: Icon(
                                          Icons.account_circle_rounded,
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
                                              context, "/orders");
                                        },
                                        child: Icon(
                                          Icons.check_circle_outline_rounded,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          addToCard(userCart);


                                          Navigator.pushNamed(
                                              context, "/cart");
                                        },
                                        child: Icon(
                                          Icons.shopping_cart,
                                          size: w * 0.09,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     GestureDetector(
                                  //       onTap: () {
                                  //         Navigator.pushNamed(
                                  //             context, "/orders");
                                  //       },
                                  //       child: Icon(
                                  //         Icons.check_circle_outline_rounded,
                                  //         size: w * 0.09,
                                  //         color: Colors.black,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
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
                                                userCart.clear();
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
