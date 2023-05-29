import 'package:bakery_project/Services/controller.dart';
import 'package:bakery_project/services/itemService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakery_project/models/order.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Controller ctrl = new Controller();
  TextEditingController quantityController = new TextEditingController();
  num price = 0;
  List<Item> userCart = getCart();
  num len = getCart().length;
  double w = 0, h = 0;
  Widget buildItem(Item item) => Card(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(255, 248, 220, 1),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: IntrinsicHeight(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.network(item.url,
                      height: h * 0.15, width: w * 0.30),
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
                        Container(
                          width: 140,
                          height: 50,
                          child: TextField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              labelText: "Quantity",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            userCart.remove(item);
                          });
                        },
                        icon: Icon(Icons.delete),
                      )
                  ),
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
          title: Text('Cart'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: h * 0.75,
              child: (userCart.isNotEmpty)
                  ? ListView(
                      children: userCart!.map(buildItem).toList(),
                    )
                  : SafeArea(
                      child: Text('No items in Cart'),
                    ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Background color
                ),
                onPressed: () async {
                  int totQuantity = 0, totPrice = 0;
                  userCart.forEach((element) {
                    totQuantity += int.parse(quantityController.text);
                    totPrice += element.price * int.parse(quantityController.text);
                  });
                  String username = ctrl.box.read("email");
                  print(totPrice.toString() +
                      " " +
                      totQuantity.toString() +
                      " " +
                      username);
                  final fbcol =
                      FirebaseFirestore.instance.collection("orders").doc();
                  final user = Order(username, totPrice, totQuantity);
                  final json = user.toJson();
                  await fbcol.set(json);
                  userCart.clear();
                  Navigator.pushNamed(context, "/home");
                },
                child: Text('Place Order')),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
        ));
  }
}
