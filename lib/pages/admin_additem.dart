import 'package:bakery_project/models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/controller.dart';

class AddItem extends StatelessWidget {
  Controller ctrl = new Controller();
  // const AddItem({Key? key}) : super(key: key);

  TextEditingController nameController = new TextEditingController();
  TextEditingController flavourController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 220,1),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Add item',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.orange
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: flavourController,
                  decoration: InputDecoration(
                    labelText: "Flavour",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.orange
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    labelText: "Image URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.orange
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.orange
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String name = nameController.text;
                    String flavour = flavourController.text;
                    String url = urlController.text;
                    int price = int.parse(priceController.text);

                    createItem(name, flavour, url, price );

                    Navigator.pushNamed(context, '/home');

                  },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // Background color
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Item',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),

                ),
              ),
              Spacer(),
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
            ],
          ),
        ),
      ),
    );
  }
}

Future createItem(String name, String flavour, String url, int price) async {
  final fbcol = FirebaseFirestore.instance.collection("items").doc();
  final item = Item(name, flavour, price, url);
  final json = item.toJson();
  await fbcol.set(json);
}
